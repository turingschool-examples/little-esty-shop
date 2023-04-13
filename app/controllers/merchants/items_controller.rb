class Merchants::ItemsController < ApplicationController
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
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])  
    if item_params[:status].present?
      @item.update(item_params)
      redirect_to merchant_items_path(@item.merchant)
    elsif @item.update(item_params)
      flash[:success] = 'Item Updated'
      redirect_to merchant_item_path(@item.merchant, @item)
    else
      flash[:notice] = 'Item Update Failed'
      redirect_to edit_merchant_item_path(@item.merchant, @item)
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end