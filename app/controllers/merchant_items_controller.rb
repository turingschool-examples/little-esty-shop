class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    if params[:change_to_enable]
      @item = Item.find(params[:change_to_enable])
      @item.update(status: "enable")
      redirect_to "/merchants/#{@merchant.id}/items"
    elsif params[:change_to_disable]
      @item = Item.find(params[:change_to_disable])
      @item.update(status: "disable")
      redirect_to "/merchants/#{@merchant.id}/items"
    end
  end

  # def enable
  #   @merchant = Merchant.find(params[:merchant_id])
  #   @item = Item.find(params[:item_id])
  #   @item.update(status: 1)
  #   redirect_to "merchants/merchant_id/items"
  # end
  #
  # def disable
  #   @merchant = Merchant.find(params[:merchant_id])
  #   @item = Item.find(params[:item_id])
  #   item.update(status: 0)
  #   redirect_to "merchants/merchant_id/items"
  # end

end
