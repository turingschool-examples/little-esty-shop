class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    @shippable_invoice_items = @merchant.ship_ready_items.order_by_oldest
  end
end
