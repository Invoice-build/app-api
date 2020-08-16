module Ethereum
  module Transaction
    class Validator
      attr_reader :eth_transaction
      
      def initialize(eth_transaction)
        @eth_transaction = eth_transaction
      end

      def call
        valid_asset?
      end

      def valid_asset
        
      end
    end
  end
end
