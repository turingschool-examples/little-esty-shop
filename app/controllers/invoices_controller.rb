class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
  
  def update
    item = Item.find(params[:id])
  end

  private
  def item_params
    params.permit(:status)
  end
end