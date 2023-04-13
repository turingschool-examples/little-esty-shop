class Merchants::InvoicesController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    # binding.pry
  end
end