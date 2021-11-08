class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @item = @items.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.new(item_params)

    if item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      redirect_to "/merchants/#{@merchant.id}/items/new"
      #put a flash here
    end
  end
end

private

def item_params
  params.permit(:id, :name, :description, :unit_price, :merchant_id)
end
