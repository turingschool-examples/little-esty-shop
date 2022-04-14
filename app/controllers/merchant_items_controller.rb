class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @merchant_items = @merchant.items
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def create
    merchant = Merchant.find(params[:id])
    item = merchant.items.new(merchant_items_params)
    item[:status] = 0
    item.save
    redirect_to "/merchants/#{merchant.id}/items"
  end

  def show
    @merchant_item = Item.find(params[:id])
    @merchant = @merchant_item.merchant
  end

  def edit
    @merchant_item = Item.find(params[:id])
    @merchant = @merchant_item.merchant
  end

  def update
    merchant_item = Item.find(params[:id])
    merchant = merchant_item.merchant

    if merchant_item.update(merchant_items_params)
      redirect_to "/merchants/#{merchant.id}/items/#{merchant_item.id}"
      flash[:notice] = "Success: The information has been successfully updated"
    else
      redirect_to "/merchants/#{merchant.id}/items/#{merchant_item.id}/edit"
    end
  end

  private

  def merchant_items_params
    params.permit(:name, :unit_price, :description)
  end
end
