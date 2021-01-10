class MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:merchant_id])
    @merchant_items = merchant.items
  end

  def show
    merchant = Merchant.find(params[:merchant_id])
    @item = merchant.items.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update!(item_params)
    flash[:success] = 'Item Updated Successfully'
    render :show
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end

end
