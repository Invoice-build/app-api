# frozen_string_literal: true

class EthTransaction::OnCreatedJob < ApplicationJob
  def perform(eth_transaction_id)
    eth_transaction = EthTransaction.find(eth_transaction_id)
    slack_service.send("*Event*: Payment made\n*ID*: #{eth_transaction_id}\n*Hash*: #{eth_transaction.tx_hash}")
  end

  private

  def slack_service
    @slack_service ||= SlackNotificationService.new
  end
end
