class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    if @item.update(item_params)
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      flash[:notice] = "Item updated successfully"
    else
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
      flash[:alert] = "Error: #{error_message(@item.errors)}"
    end
  end

  private

  def item_params
    params.permit(:id, :name, :unit_price, :description, :enabled)
  end
end
