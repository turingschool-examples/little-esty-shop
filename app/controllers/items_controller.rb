class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @enabled_items = @merchant.items.where(status: 1)
    @disabled_items = @merchant.items.where(status: 0)
  end

  def show
    find_item_and_merchant
  end

  def edit
    find_item_and_merchant
  end

  def update
    find_item_and_merchant
    @item.update(item_params)
    flash.notice = "Succesfully Updated Item Info!"
    redirect_to merchant_item_path(@merchant, @item)
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])

    #require "pry"; binding.pry
    Item.create!(item_params)
    redirect_to merchant_items_path(@merchant)
  end


  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end

  def find_item_and_merchant
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end
end
