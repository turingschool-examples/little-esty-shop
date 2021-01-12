class Merchants::InvoicesController < ApplicationController
  def index
    @invoices = Merchant.find(params[:merchant_id]).invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
  end
end
