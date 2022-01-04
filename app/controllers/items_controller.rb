class ItemsController < ApplicationController
  def index
    @items = Item.all.where(merchant: params[:merchant_id])
  end
end
