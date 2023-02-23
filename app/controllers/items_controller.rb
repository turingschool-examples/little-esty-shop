class ItemsController < ApplicationController
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    item = Item.new(item_params)
    if item.save
      redirect_to "/merchants/#{params[:merchant_id]}/items"
    end
  end

  def update 
    @item = Item.find(params[:item_id])
    if @item.status == "disabled"
      @item.update! status: 1
    else 
      @item.update! status: 0
    end 
    redirect_to "/merchants/#{params[:merchant_id]}/items"
  end

private
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :uuid)
  end
end
