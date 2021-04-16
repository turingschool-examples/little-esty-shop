class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    if params.include?(:item_status)
      if params[:item_status] == "disabled"
        item.update!(status: 1)
        redirect_to "/merchant/#{merchant.id}/items"
      else
        item.update!(status: 0)
        redirect_to "/merchant/#{merchant.id}/items"
      end
    elsif item.update!(item_params)
      flash[:message] = "Item successfully updated #{error_message(item.errors)}"
      redirect_to "/merchant/#{merchant.id}/items/#{item.id}"
    else
      flash[:error] = "Please fill in all fields. #{error_message(item.errors)}."
      redirect_to "/merchant/#{merchant.id}/items/#{item.id}/edit"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id, :status)
  end
end
