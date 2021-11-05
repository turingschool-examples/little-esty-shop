class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @merchant = Merchant.find(params[:id])
    @invoice = Invoice.find(params[:inv_id])
  end
end
