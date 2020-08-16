module Infura
  module Api
    module Transactions
      def transactions
        @transactions ||= Models::Transaction.new(self)
      end
    end
  end
end
