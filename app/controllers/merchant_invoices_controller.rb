class MerchantInvoicesController < ApplicationController
  def index
    @merchant_invoices = Merchant.find(params[:id])
  end
end