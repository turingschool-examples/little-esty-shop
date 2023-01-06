class ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
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
  #   if params[:enabled].present?
  #     @item.update(item_params)
  #     redirect_to merchant_items_path(@item.merchant)
  #   else
  #     @item.update(item_params)
  #     flash.notice = "ITEM UPDATED"
  #     redirect_to merchant_item_path(@item.merchant, @item)
  #   end
  # end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end