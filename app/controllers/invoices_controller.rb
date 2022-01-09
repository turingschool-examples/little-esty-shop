class InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    @invoice        = Invoice.find(params[:id])
    @merchant_items = @invoice.items_by_merchant(params[:merchant_id])
    @total_revenue  = @invoice.total_revenue_by_merchant(params[:merchant_id])
  end

  def update
    @item = Item.find(params[:item_id])

    @item.update(status: params[:status].to_i)

    redirect_to merchant_invoice_path(params[:merchant_id], params[:id])
  end
end
