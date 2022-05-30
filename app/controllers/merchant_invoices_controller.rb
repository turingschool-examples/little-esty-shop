class MerchantInvoicesController < ApplicationController

  def show
    @invoice = Invoice.find(params[:invoice_id])
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

end
