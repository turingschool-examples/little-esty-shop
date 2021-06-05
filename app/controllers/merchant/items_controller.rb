class Merchant::ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:id])
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
    @top_days_for_items = @merchant.top_days
    @top_days_per_merchant = @merchant.top_days_per_merchanct
  end

  def new
    # @merchant = Merchant.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:id])
    @item = Item.create(item_params)
    redirect_to "/merchants/#{@merchant.id}/items"
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end



end
