class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.new(item_params)
    if item.save
      redirect_to merchant_items_path(merchant)
    else
      flash[:alert] = "Item still not created. Please investigate."
      redirect_to new_merchant_item_path(merchant)
    end
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit

  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    item = @merchant.items.find(params[:id])
    if params[:enable] != nil
      item.update(status: 1)
    elsif params[:disable] != nil
      item.update(status: 0)
    end
    redirect_to merchant_items_path(@merchant)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
