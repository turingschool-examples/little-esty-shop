class Merchant::ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @enabled_items = @merchant.items.enabled_items
    @disabled_items = @merchant.items.disabled_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    if params[:item_status] != nil
      item.change_status(params[:item_status])
      redirect_to merchant_items_path(@merchant)
    else
      if item.update(item_params)
        flash.notice = "Item Updated"
      redirect_to merchant_item_path(params[:merchant_id], item)
      else
        flash[:error] = "Fill in unit price with integer, description with statement"
        @item = Item.find(params[:id])
        @merchant = Merchant.find(params[:merchant_id])
        render :edit
      end
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new(item_create_params)
    @item.save
    redirect_to new_merchant_item_path(@merchant)
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :item_status)
  end

  def item_create_params
    params.permit(:name, :description, :unit_price, :item_status)
  end
end
