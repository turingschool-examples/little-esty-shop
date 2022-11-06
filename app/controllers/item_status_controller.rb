class ItemStatusController < ApplicationController
  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:id])
    if params[:enabled]
      @item.update(status: 1)
      redirect_to "/merchants/#{@merchant.id}/items"
    elsif params[:disabled]
      @item.update(status: 0)
      redirect_to "/merchants/#{@merchant.id}/items"
    end
  end
end
