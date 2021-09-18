class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.create(item_params)
    redirect_to "/merchants/#{merchant.id}/items"
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
