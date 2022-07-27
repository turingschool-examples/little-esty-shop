class MerchantItemsController < ApplicationController
  
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def create
    item = Item.new(item_params)

    if item.save
      redirect_to "/merchants/#{item_params[:merchant_id]}/items"
    else
      redirect_to "/merchants/#{item_params[:merchant_id]}/items/new"
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end


  private

  def item_params
    params.permit(:id, :merchant_id, :name, :description, :unit_price)
  end
end