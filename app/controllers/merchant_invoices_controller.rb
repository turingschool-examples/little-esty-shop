class MerchantInvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:id])
    @invoices = @merchant.invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:invoice_id])
  end
end
