class ItemStatusController < ApplicationController
  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.update(item_status_params)
    redirect_to merchant_items_path
  end

  private
  def item_status_params
    params.permit(:status)
  end
end
