class Merchant::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.merchant_invoices(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
