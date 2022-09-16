class InvoicesController < ApplicationController

  def index
    
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
  end
  
end