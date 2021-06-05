class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.distinct
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = @invoice.customer
    @invoice_items = @invoice.invoice_items
  end
end
