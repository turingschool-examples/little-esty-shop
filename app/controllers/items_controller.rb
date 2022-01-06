class ItemsController < ApplicationController
  def index
    @items = Item.all.where(merchant_id: params[:merchant_id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.create(item_params)
    item.save
    redirect_to "/merchants/#{@merchant.id}/items"
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)

    redirect_to merchant_item_path(item.merchant, item), notice: "Successfully Updated"
  end

  private
    def item_params
      params.permit(:name, :description, :unit_price)
    end
end
