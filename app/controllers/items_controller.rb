class ItemsController < ApplicationController
  def show
    @items = Item.where(merchant_id: params[:merchant_id])
  end
end