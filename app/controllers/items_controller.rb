class ItemsController < ApplicationController
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    item = Item.new(item_params)
    
    if item.save

  end


  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :uuid)
  end
end
