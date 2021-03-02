class InvoicesController < ApplicationController
  def index
    @merchant_invoices = Merchant.merchant_invoices(params[:merchant_id])
  end
end
