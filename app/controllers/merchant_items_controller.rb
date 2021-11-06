class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    params[:unit_price] = (params[:unit_price].to_f * 100).to_i
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.create(item_params)
    redirect_to "/merchants/#{params[:merchant_id]}/items"
  end

  private
    def item_params
      params.permit(:name, :description, :unit_price)
    end
end
