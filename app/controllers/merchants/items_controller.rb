class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    if params[:enabled].present?
      item.update(enabled: params[:enabled])
      redirect_to "/merchants/#{@merchant.id}/items"
      flash[:notice] = "Item information successfully updated!"
    else
      item.update(item_params)
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      flash[:notice] = "Item information successfully updated!"
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.create!(item_params)
    redirect_to "/merchants/#{@merchant.id}/items"
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :enabled)
  end
end
