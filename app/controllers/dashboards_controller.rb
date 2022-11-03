class DashboardsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_top_five = Customer.top_five_customers_for(params[:merchant_id])
    @item_invoices = @merchant.invoice_items_to_ship
  end
end