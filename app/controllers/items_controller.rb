class ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
    if @item.update(item_params)
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
      flash[:message] = 'Item updated'
    else
      redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}/edit"
      flash[:error] = 'Update invalid'
    end
  end

  private

  def item_params
    params.permit(:id, :name, :description, :unit_price, :status, :created_at, :updated_at, :merchant_id)
  end
end