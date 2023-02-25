class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items.all
    @enabled_items = @merchant.items.enabled
    @disabled_items = @merchant.items.disabled
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
    @item.update(item_params)
    if @item.save
      flash[:notice] = "#{@item.name} Information has been Updated"
      if params[:item][:status]
        redirect_to "/merchants/#{@merchant.id}/items"
      else
        redirect_to "/merchants/#{@merchant.id}/items/#{item.id}"
      end
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end
end