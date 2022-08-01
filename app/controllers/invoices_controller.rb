class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    # @merchant_invoices = Invoice.merchants_invoices(@merchant.id)
  end
end
