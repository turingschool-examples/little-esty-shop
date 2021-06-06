class Merchant::DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @top_5_customers_array = @merchant.top_5_customers
    @customers = Customer.all
    @items = @merchant.items
    @ready_to_ship_items = Item.joins(:invoice_items).where(items: {merchant_id: @merchant.id}, invoice_items: {status: 1})
    @invoice_to_ship = @ready_to_ship_items.pluck(:invoice_id).join()

  end

end
