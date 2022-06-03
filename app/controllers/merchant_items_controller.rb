class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    # binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    item.update(item_params)
    # if it successfully posts
    # flash[:notice]='Item Successfully Updated'
    redirect_to "/merchants/#{merchant.id}/items", flash[:notice] = 'Item Successfully Updated'
  end

  private

  def item_params
    params.permit(
      :name,
      :description,
      unit_price: params[:unit_price].to_f / 100
    )
  end
end
