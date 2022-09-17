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
    if @item.update(item_params)
      redirect_to merchant_item_path(params[:merchant_id], params[:id])
      flash[:notice] = 'Item edited successfully!'
    else
      redirect_to edit_merchant_item_path(params[:merchant_id], params[:id])
      flash[:alert] = "Error: #{@item.errors.full_messages.to_sentence}"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end
end
