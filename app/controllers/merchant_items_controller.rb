class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @selling_price = @item.price_convert
  end

  def edit
    # binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])

    if params.has_key?(:status)
      @item = @item.update(item_params)
      redirect_to merchant_items_path(@merchant.id)
    end
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    item.update(item_params)
    redirect_to merchant_item_path(merchant.id, item.id)
    flash[:success] = "#{item.name} has been successfully updated."
  end

  private

  def item_params
    params.permit(
      :name,
      :description,
      :unit_price,
      :status
    )
  end
end