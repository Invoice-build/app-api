module Ethereum
  module Transaction
    class Service
      attr_reader :eth_transaction, :network_client_class, :eth_utils_client
      
      def initialize(eth_transaction, network_client_class: Infura::Client, eth_utils_client: EthUtilsApp::Client.new)
        @eth_transaction = eth_transaction
        @network_client_class = network_client_class
        @eth_utils_client = eth_utils_client
      end

      def fetch_data
        data = network_client.transactions.get(tx_hash: eth_transaction.tx_hash)
        input_data = if eth_transaction.native?
          nil
        else
          eth_utils_client.get("#{eth_transaction.token.standard}/decode/#{data['input']}") 
        end
        
        eth_transaction.update(data: data, input_data: input_data)
      end

      private

      def network_client
        @network_client ||= network_client_class.new(network: eth_transaction.network)
      end
    end
  end
end
