class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to(merchant_item_path)
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def change_status
    @merchant =  Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.flip_status
    @item.save
    redirect_to merchant_items_path(@merchant)
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.create!(item_params)
    redirect_to(merchant_items_path(@merchant))
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
