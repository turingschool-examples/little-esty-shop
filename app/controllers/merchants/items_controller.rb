class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @top_items = @merchant.top_5_items_by_revenue
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.find(params[:id])
    
    if item.update(item_params)
      flash[:success] = "Item Successfully Updated!"
      redirect_to merchant_item_path(merchant.id, item.id)
    else
      flash[:notice] = error_message(item.errors)
      redirect_to edit_merchant_item_path(merchant.id, item.id)
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end