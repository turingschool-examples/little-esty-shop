class Merchant::DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
    @ready_to_ship = Item.joins(:invoice_items).where("invoice_items.status != ?", 2)

    binding.pry

  end
end
