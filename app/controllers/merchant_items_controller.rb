class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def show
    @merchant = Merchant.find(params[:id])
    @item = Item.find(params[:item_id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
    @item = Item.find(params[:item_id])
  end

  def create
    merchant = Merchant.find(params[:id])
    merchant.items.create(name: params[:name], description: params[:description], unit_price: params[:unit_price])

    redirect_to "/merchants/#{merchant.id}/items"
  end

  def update
    merchant = Merchant.find(params[:id])
    item = Item.find(params[:item_id])
    item.update(item_params)

    redirect_to "/merchants/#{merchant.id}/items/#{item.id}", alert: "Notice: Item successfully updated."
  end

  def change_status
    #require "pry"; binding.pry
    merchant = Merchant.find(params[:id])

    item = Item.find(params[:item_id])
    if item.status == true
      item.update(status: false)
    elsif
     item.status == false
      item.update(status: true)
    end
    redirect_to "/merchants/#{merchant.id}/items"
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
