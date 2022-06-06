class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
    #how would i do this with a model method / not instantiating a merchant?
  end

  def show
    @item = Item.find(params[:item_id])
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def update
    item = Item.find(params[:item_id])
    # binding.pry
    if params[:status] == "1"
      item.update(status: 1)
      redirect_to "/merchants/#{item.merchant.id}/items/"
    elsif params[:status] == "0"
      item.update(status: 0)
      redirect_to "/merchants/#{item.merchant.id}/items/"
    elsif item.update(item_params)
      redirect_to "/merchants/#{item.merchant.id}/items/#{item.id}"
      flash[:notice] = "Success: Item information has been updated."
    end
  end

  def new
    @merchant = Merchant.find(params[:id])
    # binding.pry
  end

  def create
    merchant = Merchant.find(params[:id])
    merchant.items.create!(item_params)
    redirect_to "/merchants/#{merchant.id}/items"
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end


end
