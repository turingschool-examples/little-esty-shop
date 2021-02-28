class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_invoices = @merchant.invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_invoice = Invoice.find(params[:id])
    @status_format = @merchant_invoice.status_format
  end
end
