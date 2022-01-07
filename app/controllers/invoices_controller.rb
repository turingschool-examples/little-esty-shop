class InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    @merchant_items = @invoice.items_by_merchant(params[:merchant_id])
  end
end
