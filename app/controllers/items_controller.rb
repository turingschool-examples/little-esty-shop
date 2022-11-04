class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.items
    @merchant_top_items = @merchant.top_5_items
  end

  def show
    @item = Item.find(params[:id])
    @item_price = @item.unit_price
  end 

  def update
    item = Item.find(params[:id])
    if params[:button] == 'true' && item.status == 'enabled'
      # item.status = 'disabled'
      item.update!(status: 'disabled')
    elsif params[:button] == 'true' && item.status == 'disabled'
      # item.status = 'enabled'
      item.update!(status: 'enabled')
    end
    # item.save
    redirect_to "/merchants/#{item.merchant.id}/items"
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new(name: params[:name], description: params[:description], unit_price: params[:price], status: params[:status].to_i)
    @item.save
    redirect_to "/merchants/#{@merchant.id}/items"
  end

end