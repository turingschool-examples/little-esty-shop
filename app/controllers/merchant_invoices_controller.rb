class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @invoices = @merchant.invoices
  end

  def show
    @merchant = Merchant.find(params[:id])
    @invoice = Invoice.find(params[:invoice_id])
  end

end