class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update_status

  end


  def update
    if !params[:status].nil?
      @item = Item.find(params[:id])
      @item.update(item_params)
      @item.save
      redirect_to merchant_items_path(@item.merchant)
    else
      @item = Item.find(params[:id])
      @item.update(item_params)
      redirect_to merchant_item_path(@item.merchant, @item)
    end
  end


  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
