class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
  end

  def items_index
    @merchant = Merchant.find(params[:id])
  end

  def items_show
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_item = Item.find(params[:merchant_item_id])
  end

  def items_edit
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_item = Item.find(params[:merchant_item_id])
  end

  def items_update
      @merchant_item = Item.find(params[:id])
      @merchant = @merchant_item.merchant
      @merchant_item.update(name: params[:name], description: params[:description], unit_price: params[:unit_price])
      redirect_to "/merchants/#{@merchant.id}/items/#{@merchant_item.id}"
  end
end
