class PollForConfirmationJob < ApplicationJob
  queue_as :critical

  def perform(id, resource_model: EthTransaction)
    resource = resource_model.find(id)
    return if resource.confirmed_at.present? || resource.failed_at.present?

    confirmations = Etherscan::Service.get_confirmations(resource.tx_hash)

    if confirmations
      puts "#{confirmations} confirmations for #{resource.tx_hash}"

      if confirmations >= 7
        confirmed_at = Etherscan::Service.get_confirmed_at(resource.tx_hash)
        resource.update!(confirmed_at: confirmed_at)
      else
        PollForConfirmationJob.set(wait: 5.seconds).perform_later(resource.id)
        return
      end
    else
      if resource.updated_at > 5.minutes.ago
        puts "Tx #{resource.tx_hash} probably not available via Etherscan API yet"
        PollForConfirmationJob.set(wait: 5.seconds).perform_later(resource.id)
        return
      else
        puts "Tx #{resource.tx_hash} failed!"
        resource.update!(failed_at: Time.now)
      end
    end
  end

end
