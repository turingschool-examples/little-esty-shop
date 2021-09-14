class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.update(item_params)

    if params[:enable]
      redirect_to "/merchants/#{@merchant.id}/items/"
    elsif
      flash[:notice] = "Item has been updated succesfully"
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
    end
  end


  private
  def item_params
    params.permit(:name, :description, :unit_price, :enable)
  end
end
