class MerchantsController < ApplicationController

  def show 
    @merchant = Merchant.find(params[:merchant_id])
    @shippable_items = @merchant.items.not_yet_shipped
    # @item = Item.not_yet_shipped(merchant_id)
  end
end