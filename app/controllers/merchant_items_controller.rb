class MerchantItemsController < ApplicationsController
  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
  end

  def show
    # binding.pry
    @item = Item.find(params[:item_id])
  end
end
