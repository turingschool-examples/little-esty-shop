class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
    @merchant = @item.merchant
  end

  def edit
    @item = Item.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @merchant.items.create(item_params)
    redirect_to "/merchants/#{@merchant.id}/items"
  end

  # Will need to update to handle edge case of improper unit_price entry
  # at a later date
  # e.g. Typing in as float (3.50) instead of integer (350)
  def update
    item = Item.find(params[:id])
    item.update(item_params)
    flash[:notice] = "Item successfully updated!"
    if params[:status].nil?
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
    else
      redirect_to "/merchants/#{item.merchant_id}/items"
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
