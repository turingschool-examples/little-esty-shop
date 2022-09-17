class InvoicesController < ApplicationController
 before_action :set_merchant, only: [:index, :show]

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  private
  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
  
end