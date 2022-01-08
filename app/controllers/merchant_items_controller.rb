class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @enabled_items_array = @merchant.items.enabled_items
    @disabled_items_array = @merchant.items.disabled_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:item_id])
    if params[:status]
      item.update(item_params)
      redirect_to "/merchants/#{merchant.id}/items"
    else
      item.update(item_params)
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}",  notice: "Item Successfully Updated"
    end
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.create!(item_params)
    redirect_to "/merchants/#{merchant.id}/items"
  end



    private

    def item_params
      params.permit(:name, :description, :unit_price, :status)
    end
end
