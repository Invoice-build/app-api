module Ethereum
  module Transaction
    class InputData
      attr_reader :eth_transaction
      
      def initialize(eth_transaction)
        @eth_transaction ||= eth_transaction
      end

      def call
        case eth_transaction.token.standard.to_sym
        when :erc20
          return Serializers::Erc20InputData.new(input_data).call
        else
          return nil
        end
      end

      private

        def input_data
          @input_data ||= eth_transaction.input_data
        end
    end
  end
end
