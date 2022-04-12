class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def create
    merchant = Merchant.find(params[:id])
    item = merchant.items.create(item_params)
    redirect_to "/merchants/#{merchant.id}/items"
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if params[:disable]
      item.update(status: 0)
      redirect_to "/merchants/#{item.merchant_id}/items"
    elsif params[:enable]
      item.update(status: 1)
      redirect_to "/merchants/#{item.merchant_id}/items"
    elsif item.update(item_params)
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
      flash[:success] = "Information Successfully Updated"
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
