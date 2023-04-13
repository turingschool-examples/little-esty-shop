class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end
  
  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if @item.update(item_params)
      if params[:status] == "Enable"
        @item.status_update(1)
        redirect_to "/merchants/#{@merchant.id}/items/"
        flash[:alert] = "Information Successfully Updated!"
      elsif params[:status] == "Disable"
        @item.status_update(0)
        redirect_to "/merchants/#{@merchant.id}/items/"
        flash[:alert] = "Information Successfully Updated!"
      else
        redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
        flash[:alert] = "Information Successfully Updated!"
      end

    else
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
      flash[:alert] = "Error: #{error_message(@item.errors)}"
    end

  end
  
  private

  def item_params
    params.permit(:id, :name, :description, :unit_price)
  end
end