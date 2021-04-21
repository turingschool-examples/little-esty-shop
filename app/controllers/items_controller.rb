class ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @enabled_items = Item.all.enabled
    @disabled_items = Item.all.disabled
    @top_items = Item.top_five_items(@merchant.id)
    @top_days = @top_items.map {|item| item.best_day.first}
    # binding.pry
  end

  def show
    @item = Item.find(params[:id])
    @merchant = @item.merchant
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.new({name: params[:name], description: params[:description], unit_price: params[:unit_price], able: params[:able], merchant_id: @merchant.id})
    if item.save
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      flash[:alert] = "ERROR: Item not created."
      redirect_to "/merchants/#{@merchant.id}/items/new"
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @item = Item.find(params[:id])
    @merchant = @item.merchant
  end

  def update
    item = Item.find(params[:id])
    @merchant = item.merchant
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
    if item.save
      flash[:notice] = "Item was successfully updated."
      redirect_to "/merchants/#{@merchant.id}/items"
    else
      flash[:alert] = "ERROR: Item not updated."
      redirect_to "/items/#{item.id}/edit"
    end
  end
end
