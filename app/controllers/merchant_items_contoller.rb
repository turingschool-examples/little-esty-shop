class MerchantItemsController < ApplicationController

  def index
    @item = Item.find(params[:id])
  end
end