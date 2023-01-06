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
    @item.update(merchant_item_params)    
    redirect_to merchant_item_index_path(@merchant)
  
    flash[:alert] = "Succesfully updated"
  end

  private
  def merchant_item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end