class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def show
    @item = Item.find(params[:id])
  end 

  def edit
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    # binding.pry
    @item.update(name: params[:name], description: params[:description], unit_price: params[:unit_price])
    
    redirect_to "/merchant/#{@merchant.id}/item/#{@item.id}"
  
    flash[:alert] = "Succesfully updated"
  end
end