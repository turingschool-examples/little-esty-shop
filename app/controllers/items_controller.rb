class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    # require 'pry'; binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end
  
  def update
    # require 'pry'; binding.pry
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    item.update(item_params)
    if item.update(item_params)
    # require 'pry'; binding.pry
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}"
      flash[:alert] = 'Item information has been successfully updated'
    else
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}/edit"
      flash[:alert] = 'Item was not updated, please update one of the fields.'
    end
  end

private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end