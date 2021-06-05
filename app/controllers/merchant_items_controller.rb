class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    if params[:change_to_enable]
      @item = Item.find(params[:change_to_enable])
      @item.update(status: "enable")
      redirect_to "/merchants/#{@merchant.id}/items"
    elsif params[:change_to_disable]
      @item = Item.find(params[:change_to_disable])
      @item.update(status: "disable")
      redirect_to "/merchants/#{@merchant.id}/items"
    end
    @top_items = @merchant.top_5
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.create(item_params)
    redirect_to "/merchants/#{@merchant.id}/items"
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :status)
  end



end
