class MerchantItemsController < ApplicationController
  def index
    @items = Item.all
  end
end
