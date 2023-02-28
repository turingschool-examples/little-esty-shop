class Merchants::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.distinct
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:id])
    @customer = @invoice.customer
    @invoice_items = InvoiceItem.where(invoice_id: params[:id])
  end
end