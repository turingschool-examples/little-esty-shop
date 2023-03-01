class InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:id])
    @total_revenue = @invoice.calc_total_revenue
  end
end