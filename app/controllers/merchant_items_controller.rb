class MerchantItemsController < ApplicationController
  def show
    @item = Item.where('merchant_id = ? AND id = ?', params[:merchant_id], params[:item_id]).first
  end

  def edit
  end

  def update
    item = Item.where('merchant_id = ? AND id = ?', params[:merchant_id], params[:item_id]).first

    item.update(item_params)

    redirect_to "/merchants/#{params[:merchant_id]}/items/#{params[:item_id]}"
    # binding.pry 
    flash[:notice] = "Successfully updated"
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
