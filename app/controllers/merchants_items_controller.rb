class MerchantsItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = Item.where(merchant_id: @merchant.id)
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    
    if params[:swap] == "true"
      @item.toggle_status
      @item.save
      redirect_to merchant_items_path(@merchant.id)
    else
      @item.update(update_params)
      redirect_to merchant_item_path(@merchant.id, @item.id), notice: "Item Updated Successfully"
    end
  end

  private

  def update_params
    params.permit(:name, :description, :unit_price)
  end
end