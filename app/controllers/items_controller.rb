class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items 
  end

  def show 
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])   
    @merchant = @item.merchant
    if params[:disable]
      @item.update(status: params[:disable].to_i)
      redirect_to merchant_items_path(@merchant.id) 
     elsif params[:enable] 
      redirect_to merchant_items_path(@merchant.id)
    end 
  end

  def new 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    item = Item.create(name: params[:name], description: params[:description], unit_price: params[:unit_price], merchant_id: params[:merchant_id], status: params[:status])
    merchant = Merchant.find(params[:merchant_id])
    item.save 
    redirect_to merchant_items_path(merchant.id)
  end
end
