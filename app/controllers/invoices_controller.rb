class InvoicesController < ApplicationController
  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @invoices = @merchant.invoices
    else
      @invoices = Invoice.all
    end
  end

  def show
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @invoice = @merchant.invoices.find(params[:id])
      @items = @invoice.items
      # @item = @invoice_items.find(params[:id])
    else
      @invoice = Invoice.find(params[:id])
    end
  end
end
