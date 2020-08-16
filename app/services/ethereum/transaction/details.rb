module Ethereum
  module Transaction
    class Details < SimpleDelegator
      include Utils

      def call
        {
          from: _data.from,
          to: recipient,
          amount: amount
        }
      end

      def recipient
        @recipient ||= if native?
          _data.to
        else
          _input_data.recipient
        end
      end

      def amount
        @amout ||= if native?
          from_wei Integer(_data.value)
        else
          _input_data.amount
        end
      end
  
      private
  
      def _data
        @_data ||= OpenStruct.new(data)
      end

      def _input_data
        @_input_data ||= OpenStruct.new(InputData.new(self).call)
      end
    end
  end
end
