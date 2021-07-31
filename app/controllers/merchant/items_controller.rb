class Merchant::ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:item_id])
    merchant = Merchant.find(params[:id])
    if params[:status].present?
      item.update!(status: params[:status].to_i)
    end
    redirect_to "/merchants/#{params[:id]}/items"
  end
end
