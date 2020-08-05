module Etherscan
  module Service
    extend self

    def get_confirmations(txhash)
      tx = Client.get_transaction_receipt(txhash)
      bn = Client.get_block_number
      return false unless tx
      return false unless tx.dig('blockNumber')
      return false unless tx.dig('status').hex == 1

      bn.to_i(16) - tx.dig('blockNumber').to_i(16) + 1
    end

    def get_confirmed_at(txhash)
      tx = Client.get_transaction_receipt(txhash)
      return false unless tx
      return false unless tx.dig('blockNumber')
      return false unless tx.dig('status').hex == 1

      block = Client.get_block_by_number(tx.dig('blockNumber'))

      Time.at(block.dig('timestamp').hex)
    end

    def find_confirmed_transaction(startblock:, nonce:, address:)
      return false unless startblock
      return false unless nonce
      return false unless address

      list = Client.get_list_of_transaction(startblock, address)
      return false unless list.any?

      list.find { |tx| tx.dig('txreceipt_status').hex == 1 && tx.dig('nonce') == nonce }
    end
    
  end
end