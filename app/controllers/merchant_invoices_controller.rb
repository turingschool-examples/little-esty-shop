class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show 
    @invoice = Invoice.find(params[:invoice_id])
  end
end
