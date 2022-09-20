class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @top_five = @merchant.top_five_revenue
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

    if params.has_key?(:status)
      item.update(item_params)
      redirect_to merchant_items_path(merchant.id)
    else
      item.update(item_params)
      redirect_to merchant_item_path(merchant.id, item.id)
      flash[:success] = "#{item.name} has been successfully updated."
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    params[:unit_price] = (params[:unit_price].to_f * 100).to_i
    Item.create!(item_params)
    redirect_to merchant_items_path(params[:merchant_id])
  end

  private

  def item_params
    params.permit(
      :name,
      :description,
      :unit_price,
      :merchant_id,
      :status
    )
  end
end