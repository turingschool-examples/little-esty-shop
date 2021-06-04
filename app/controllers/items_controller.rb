class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    item.update(item_params)
    if item.save
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}"
      flash[:notice] = "Item information has been successfully updated!"
    else
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}/edit"
      flash[:alert] = "Error: #{item.errors.full_messages.to_sentence}"
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
