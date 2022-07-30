class ItemsController < ApplicationController
  def index
      @merchant = Merchant.find(params[:merchant_id])
      @items = Item.where(merchant_id: params[:merchant_id])
  end

  def show
      @item = Item.find(params[:id])
  end

  def edit
      @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    if params[:status] == 'enabled'
        item.enabled!
        redirect_to request.referrer
        flash.notice = "#{item.name} has been enabled"
    elsif params[:status] == 'disabled'
        item.disabled!
        redirect_to request.referrer
        flash.notice = "#{item.name} has been disabled"
    else
        item.update(item_params)
        redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
        flash.notice = "#{item.name} has been successfully updated"
    end
  end

  def new

  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.new(item_params)
    if item.save
      redirect_to merchant_items_path
    else
      redirect_to new_merchant_items_path
      flash[:error] = "Unable to create items."
    end
  end

  private
  def item_params
      params.permit(:name, :unit_price, :description, :status)
  end
end
