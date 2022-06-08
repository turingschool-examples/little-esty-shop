class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @top5items = @merchant.top_5_items
    @items_enabled = @merchant.enabled_items
    @items_disabled = @merchant.disabled_items
    @items_best_day
  end

  def show
    @merchant=Merchant.find(params[:merchant_id])
    @item=Item.find(params[:item_id])
  end

  def new
    @merchant=Merchant.find(params[:merchant_id])
  end

  def create 
    merchant=Merchant.find(params[:merchant_id])
    item = merchant.items.create(item_params)
    item.save
    redirect_to "/merchants/#{merchant.id}/items"
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def update
    @item = Item.find(params[:item_id])
    item_status = @item.status
    @merchant = Merchant.find(params[:merchant_id])
    @item.update(item_params)
    flash[:success] = 'You have successfully updated this item'

      if item_status == @item.status
    redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      else 
    redirect_to "/merchants/#{@merchant.id}/items"
      end
    end
  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :status, :created_at, :updated_at, :merchant_id)
  end
end
