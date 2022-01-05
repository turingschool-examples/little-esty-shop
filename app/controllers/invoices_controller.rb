class InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = Invoice.merchants_invoices(@merchant)
  end

  def show 
    @invoice = Invoice.find(params[:id])
  end

end
