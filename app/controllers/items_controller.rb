class ItemsController < ApplicationController

  def index
    @enabled_items = Item.all.enabled
    @disabled_items = Item.all.disabled
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:item_id])
  end

  def create
    @merchant = Merchant.find(params[:id])
    item = Item.new({name: params[:name], description: params[:description], unit_price: params[:unit_price], able: params[:able], merchant_id: @merchant.id})
    item.save
    redirect_to "/merchants/#{@merchant.id}/items"
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:item_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:item_id])
    if params[:name]
      item.update({
        name: params[:name],
        description: params[:description],
        unit_price: params[:unit_price],
        able: params[:able]
        })
    else
      item.update({able: params[:able]})
    end
    item.save
    flash[:alert] = "Item was successfully updated."
    redirect_to "/merchants/#{@merchant.id}/items"
  end

end
