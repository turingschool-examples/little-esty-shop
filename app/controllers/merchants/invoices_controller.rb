class Merchants::InvoicesController < ApplicationController
  def index
    @merchants = Merchant.find(params[:id])
    # binding.pry
  end

  def show
    @invoice = Invoice.find(params[:id])
    #binding.pry
    #@merchants = Merchant.find(params[:merchant_id])
  end

end
