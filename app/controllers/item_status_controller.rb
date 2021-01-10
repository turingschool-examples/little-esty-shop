class ItemStatusController < ApplicationController
  def update
    # require "pry"; binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.update(item_status_params)
    redirect_to merchant_items_path
  end
end
