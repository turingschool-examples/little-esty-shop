class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    
  end
end