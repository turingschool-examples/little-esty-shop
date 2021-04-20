class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @enabled_items = Item.enabled_items
    @disabled_items = Item.disabled_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def new
    @item = Merchant.find(params[:merchant_id])
  end

  def create
    item = Item.new(item_params)

    if item.save
      redirect_to "/merchants/#{item_params[:shelter_id]}/items"
    else
      redirect_to "/merchants/#{item_params[:shelter_id]}/items/new"
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end

  def update
    @item = Item.find(params[:id])
    merchant_id = @item.merchant_id
    @merchant = Merchant.find(merchant_id)
    @item.update(item_params)
    redirect_to "/merchants/#{merchant_id}/items"
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
