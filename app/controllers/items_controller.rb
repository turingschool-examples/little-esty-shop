class ItemsController < ApplicationController


  def index
    @merchant = Merchant.find(params[:id])
  end


  def update
    @merchant = Merchant.find(params[:id])
    if !params[:enable].nil?
      item = Item.find(params[:enable])
      item.update(status: 0)
    elsif !params[:disable].nil?
      item = Item.find(params[:disable])
      item.update(status: 1)
    end
    redirect_to "/merchants/#{@merchant.id}/items"
  end
  
  def show
    @item = Item.find(params[:id])
  end
end
