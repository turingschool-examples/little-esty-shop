class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items.distinct
    @enabled_items = @items.where('enabled = true', params[:enabled])
    @disabled_items = @items.where('enabled = false', params[:enabled])
  end

  def update
    @item = Item.find(params[:id])
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @item.toggle(:enabled).save
      redirect_to(merchant_items_path(@merchant))
    else 
      @item.update(item_params)
      @merchant = @item.merchant
      redirect_to("/merchants/#{@merchant.id}/items/#{@item.id}", alert: "#{@item.name} has been successfully updated")
    end
  end

  def show
    @item = Item.find(params[:id])
    @merchant = @item.merchant
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.new(item_params)
    if item.save
      redirect_to(merchant_items_path(@merchant))
    else
      redirect_to(new_merchant_item_path(@merchant))
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :enabled, :merchant_id)
  end
end
