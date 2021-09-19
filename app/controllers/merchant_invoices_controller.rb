class MerchantInvoicesController < ApplicationController
  def index
    @merchant_invoices = Invoice.merchant_invoices(params[:merchant_id])
  end
end
