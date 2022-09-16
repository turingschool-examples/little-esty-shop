class ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_item = Item.find(params[:id])
    if params[:enabled].present?
      @merchant_item.update(item_params)
      # require 'pry'; binding.pry
      redirect_to merchant_items_path(@merchant)
    else     
      @merchant_item.update(item_params)
      redirect_to "/merchants/#{@merchant.id}/items/#{@merchant_item.id}"
      flash[:notice] = "***NOTICE: Merchant Item attribute information has been successfullly updated***"
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :enabled)
  end
end
