class ItemsController < ApplicationController
  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.create(item_params)

    if item.save
      redirect_to "/merchants/#{merchant.id}/items"
    else
      # flash[:alert] = "Error: missing information. Please fill in all fields"
      redirect_to "/merchants/#{merchant.id}/items/new"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
