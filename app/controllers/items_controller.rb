class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items.distinct
    @enabled_items = @items.where(params[:enabled] = 'true')
    @disabled_items = @items.where('enabled = false', params[:enabled])
  end

  def edit
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.toggle(:enabled).save
    redirect_to(merchant_items_path(@merchant))
  end
end
