class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @customers = @merchant.customers
    @invoice_items = @merchant.invoice_items
  end
end
