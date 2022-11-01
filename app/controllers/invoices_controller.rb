class InvoicesController < ApplicationController
  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @invoices = @merchant.invoices
    else
      @invoices = Invoice.all
    end
  end
end
