class MerchantItemsController < ApplicationController

  def index
    repo_name
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    repo_name
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def edit
    repo_name
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to "/merchants/#{merchant.id}/items/#{item.id}", notice: "Item Successfully Updated"
  end

  def new
    repo_name
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.create()
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.items.create!(item_params)
    redirect_to "/merchants/#{merchant.id}/items"
  end

  private

    def item_params
      params.require(:item).permit(:name, :description, :unit_price, :status)
    end

end
