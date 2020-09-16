module Ethereum
  module Transaction
    class Details < SimpleDelegator
      include Utils

      def call
        {
          from: _data.from,
          to: recipient,
          amount: amount,
          native: is_native?,
          token_address: token_address
        }
      end

      def recipient
        @recipient ||= if is_native?
          _data.to
        else
          _input_data.recipient
        end
      end

      def value
        from_wei Integer(_data.value)
      end

      def amount
        @amout ||= if is_native?
          value
        else
          if _token.decimals != 18
            _input_data.amount * 10 ** (18 - _token.decimals)
          else
            _input_data.amount
          end
        end
      end

      def is_native?
        _data.input == '0x' || value > 0
      end

      def token_address
        @token_address ||= if is_native?
          genesis_address
        else
          _data.to
        end
      end
  
      private
  
      def _data
        @_data ||= OpenStruct.new(data)
      end

      def _input_data
        @_input_data ||= OpenStruct.new(InputData.new(self, token_address).call)
      end

      def _token
        @_token ||= Token.where('lower(address) = ? AND network = ?', token_address&.downcase, network).take
      end
    end
  end
end
