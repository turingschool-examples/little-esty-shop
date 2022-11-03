class ItemsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
    if params[:merchant_id]
      @merchant.items 
    end
  end
  
  def show
    @item = Item.find(params[:id])
  end


  def edit
    @item = Item.find(params[:id])
  end



  def update 
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.update!(item_params)
    #@item.update(status: params[:status])
    #@item.save 
    flash.notice = "The Information Has Successfully Updated"
    redirect_to "/merchants/#{@merchant.id}/items"
    #redirect_to "/merchants/#{@item.merchant.id}/items/#{@item.id}"

  end

  def new 
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create 
    @merchant = Merchant.find(params[:merchant_id])
    @merchant.items.create!(item_params)
    redirect_to merchant_items_path(@merchant)
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end


end