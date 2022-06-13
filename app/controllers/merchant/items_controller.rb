class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    Item.create(item_params)
    redirect_to merchant_items_path(@merchant.id)
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

    if params[:item_status].present?
      redirect_to merchant_items_path(@merchant.id)

    else
      redirect_to merchant_item_path(@merchant.id, @item.id)
      flash.alert = "#{@item.name} has been updated"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :item_status, :merchant_id)
  end
end
