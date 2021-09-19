class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_invoices = Invoice.merchant_invoices(params[:merchant_id])
  end
end
