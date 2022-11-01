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
    @item = Item.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])

    if item.update(item_params)
      flash[:notice] = "Successfully Updated #{item.name}"
      redirect_to merchant_item_path(merchant, item)
    else
      flash[:alert] = item.errors.full_messages.to_sentence
      redirect_to edit_merchant_item_path(merchant, item)
    end
  end

private
  def item_params
    params.permit(:name, :description, :unit_price)
  end
end