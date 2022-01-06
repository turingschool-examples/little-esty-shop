class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:item_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:item_id])
    item.update(item_params)
    # flash[:notice] = "Item Successfully Updated"
    # binding.pry
    # if item.save
    redirect_to "/merchants/#{merchant.id}/items/#{item.id}",  notice: "Item Successfully Updated"
    # else
    # end
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def create
    @merchant = Merchant.find(params[:id])
  end



  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
