class InvoicesController < ApplicationController
  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @invoices = @merchant.invoices
    else
      @invoices = Invoice.all
    end
  end

  def show
    if params[:merchant_id]
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:id])
    else
      @invoice = Invoice.find(params[:id])
    end
  end
end
