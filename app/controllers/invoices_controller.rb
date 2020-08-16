class InvoicesController < ApplicationController
  # GET /invoices/:id
  def show
    invoice = Invoice.find(params[:id])
    render json: invoice, status: :ok
  end

  # POST /invoices
  def create
    invoice = Invoice.new(invoice_params)

    if invoice.save
      render json: invoice, status: :ok
    else
      render json: invoice.errors, status: :unprocessable_entity
    end
  end

  # PATCH /invoices/:id
  # TODO: only allow if signed in
  def update
    invoice = Invoice.find(params[:id])

    if invoice.update(invoice_params)
      render json: invoice, status: :ok
    else
      render json: invoice.errors, status: :unprocessable_entity
    end
  end

  private

  def invoice_params
    contact_attributes = [
      :id, :business_name, :contact_name, :business_reg_number, :tax_number, :email, :phone,
      address_attributes: [:id, :address_1, :address_2, :district, :city, :postcode, :country]
    ]
    line_items_attributes = [:id, :description, :quantity, :quantity_type, :unit_price, :_destroy]

    params.require(:invoice).permit(
      :number, :due_at, :description, :tax_bps, :payment_address, :token_id, :network,
      issuer_contact_attributes: contact_attributes,
      client_contact_attributes: contact_attributes,
      line_items_attributes: line_items_attributes
    )
  end
end
