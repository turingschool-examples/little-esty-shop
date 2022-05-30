class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
    #how would i do this with a model method / not instantiating a merchant?
  end

  def show
    @item = Item.find(params[:item_id])
  end
end
