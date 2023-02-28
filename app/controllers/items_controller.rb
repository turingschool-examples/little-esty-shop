class ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @top_5_items = @items.top_5_by_revenue
    @enabled_items = @items.enabled
    @disabled_items = @items.disabled
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = Item.new(item_params)
    if item.valid?
      item.save
      redirect_to "/merchants/#{merchant.id}/items"
    else
      flash[:notice] = 'Invalid input'
      redirect_to "/merchants/#{merchant.id}/items"
    end
  end
  
  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
    else
      flash[:notice] ='Invalid input'
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}/edit"
    end
  end

  def status_update
    item = Item.find(params[:item_id])
    item.update!(status: params[:status])
    redirect_to "/merchants/#{item.merchant_id}/items"
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :status)
  end
end