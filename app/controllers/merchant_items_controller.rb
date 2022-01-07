class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    item.update(item_params)
    # flash[:notice] = "Item Successfully Updated"
    # binding.pry
    # if item.save
    redirect_to "/merchants/#{merchant.id}/items/#{item.id}",  notice: "Item Successfully Updated"
    # else
    # end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end
