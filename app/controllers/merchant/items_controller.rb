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

  

  def update
    @item = Item.find(params[:id])
    @item.update(name: params[:name], 
                 description: params[:description], 
                 unit_price: params[:unit_price])
    redirect_to merchant_item_path(@item.merchant, @item)
  end
end
