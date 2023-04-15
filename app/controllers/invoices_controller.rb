class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
  
  def update
    require 'pry'; binding.pry
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to merchants_invoice_path
  end

  private
  def item_params
    params.permit(:status)
  end
end