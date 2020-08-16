module Ethereum
  module Transaction
    class Worker < ApplicationJob
      queue_as :default
  
      def perform(event_name, eth_transaction_id:, **params)
        with_service(eth_transaction_id) do |service|
          case event_name.to_sym
          when :fetch_data
            service.fetch_data
          end
        end
      end

      private

      def with_service(eth_transaction_id)
        EthTransaction.find(eth_transaction_id).tap do |eth_transaction|
          yield Service.new(eth_transaction)
        end
      end
    end
  end
end
