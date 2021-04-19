class ItemsController < ApplicationController

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:item_id])
    redirect
  end

  # def item_index
  #   @merchant = Merchant.find(params[:id])
  #   @items = @merchant.items.all
  # end

  def new
  end

  def create
  end


  def update
  end

end
