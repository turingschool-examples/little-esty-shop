class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:item_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:item_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.find(params[:item_id])
      @item.update(item_params)
        redirect_to "/merchants/#{@merchant.id}/items/#{@item.id}"
        flash.alert = "#{@item.name} has been updated"
    end

  private
    def item_params
      params.permit(:name, :description, :unit_price)
    end
end
