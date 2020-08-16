class PollForConfirmationJob < ApplicationJob
  queue_as :critical

  attr_reader :resource

  def perform(id, resource_model: EthTransaction)
    @resource = resource_model.find(id)
    return if resource.confirmed_at.present? || resource.failed_at.present?

    confirmations = etherscan_service.get_confirmations(resource.tx_hash)

    if confirmations
      puts "#{confirmations} confirmations for #{resource.tx_hash}"

      if confirmations >= 5
        confirmed_at = etherscan_service.get_confirmed_at(resource.tx_hash)
        resource.update!(confirmed_at: confirmed_at)
      else
        PollForConfirmationJob.set(wait: 10.seconds).perform_later(resource.id)
        return
      end
    else
      if resource.updated_at > 5.minutes.ago
        puts "Tx #{resource.tx_hash} probably not available via Etherscan API yet"
        PollForConfirmationJob.set(wait: 10.seconds).perform_later(resource.id)
        return
      else
        puts "Tx #{resource.tx_hash} failed!"
        resource.update!(failed_at: Time.now)
      end
    end
  end

  private

  def etherscan_service
    @etherscan_service ||= Etherscan::Service.new(network: resource.network)
  end
end
