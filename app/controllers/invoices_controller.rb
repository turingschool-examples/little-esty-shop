class InvoicesController < ApplicationController
  def index
    # require 'pry'; binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
