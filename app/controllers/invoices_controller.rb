class InvoicesController < ApplicationController
  def index
    @merchant_invoices = Merchant.merchant_invoices(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
