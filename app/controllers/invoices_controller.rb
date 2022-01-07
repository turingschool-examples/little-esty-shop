class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = Invoice.all.where(merchant_id: params[:merchant_id])
  end
end
