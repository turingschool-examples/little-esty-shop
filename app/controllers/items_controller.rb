class ItemsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @items = Item.where(merchant_id: params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    require 'pry'; binding.pry
  end
  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def update
    # require 'pry'; binding.pry
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:item_id])
    item.update(item_params)
    # require 'pry'; binding.pry
    redirect_to "/merchants/#{merchant.id}/items/#{item.id}"
  end

  def status_update
    # merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:item_id])
    # require 'pry'; binding.pry
    item.update!(status: params[:status])
    item.save
    # require 'pry'; binding.pry
    redirect_to "/merchants/#{item.merchant_id}/items"
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :status)
  end
end