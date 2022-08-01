class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    # @customer = Customer.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
  end
end
