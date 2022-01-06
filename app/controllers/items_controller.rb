class ItemsController < ApplicationController
  def index
    @items = Item.all.where(merchant_id: params[:merchant_id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if params[:item_status]
      item.update(item_params)
      redirect_to merchant_items_path(item.merchant)
    else
      item.update(item_params)
      redirect_to merchant_item_path(item.merchant, item), notice: "Successfully Updated"
    end
  end

  private
    def item_params
      params.permit(:name, :description, :unit_price, :item_status)
    end
end
