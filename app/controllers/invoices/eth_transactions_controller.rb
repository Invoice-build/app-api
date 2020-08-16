module Invoices
  class EthTransactionsController < ApplicationController

    # GET /invoices/:invoice_id/eth_transactions/:id
    def show
      transaction = invoice.eth_transactions.find(params[:id])
      render json: transaction, status: :ok
    end

    # GET /invoices/:invoice_id/eth_transactions
    def index
      render json: invoice.eth_transactions, status: :ok
    end
  
    # POST /invoices/:invoice_id/eth_transactions
    def create
      tx = invoice.eth_transactions.build(eth_transaction_params)
  
      if tx.save
        render json: tx, status: :created
      else
        render json: tx.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def eth_transaction_params
      params.require(:eth_transaction).permit(:tx_hash, :reference, :network)
    end

    def invoice
      @invoice ||= Invoice.find(params[:invoice_id])
    end
  end
end
