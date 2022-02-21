class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    @shippable_invoice_items = @merchant.ship_ready_items
  end
end
