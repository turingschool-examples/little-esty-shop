class MerchantItemsController < ApplicationController
  def index
  end

  def show
    @item = Item.find(params[:item_id])
  end
end
