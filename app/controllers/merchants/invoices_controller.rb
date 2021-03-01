class Merchants::InvoicesController < ApplicationController
  def show
    @invoice = Invoice.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end
end
