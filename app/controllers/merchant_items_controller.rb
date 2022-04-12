class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @merchant_items = @merchant.items
  end

  def show
    @merchant_item = Item.find(params[:id])
    @merchant = @merchant_item.merchant
  end

  def edit
    @merchant_item = Item.find(params[:id])
    @merchant = @merchant_item.merchant
  end

  def update
    merchant_item = Item.find(params[:id])
    merchant = merchant_item.merchant

    if merchant_item.update(merchant_items_params)
      redirect_to "/merchants/#{merchant.id}/items/#{merchant_item.id}"
      flash[:notice] = "Success: The information has been successfully updated"
    else
      redirect_to "/merchants/#{merchant.id}/items/#{merchant_item.id}/edit"
    end
  end

  private

  def merchant_items_params
    params.permit(:name, :unit_price, :description)
  end
end
