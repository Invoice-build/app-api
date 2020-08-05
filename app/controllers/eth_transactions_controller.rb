class EthTransactionsController < ApplicationController

  # POST /eth_transactions
  def create
    tx = EthTransaction.new(eth_transaction_params)

    if tx.save
      render json: tx, status: :created
    else
      render json: tx.errors, status: :unprocessable_entity
    end
  end

  private

  def eth_transaction_params
    params.require(:eth_transaction).permit(:tx_hash, :reference, :transactable_id, :transactable_type)
  end
end
