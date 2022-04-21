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
    item = Item.find(params[:id])
    merchant = Merchant.find(params[:merchant_id])
    if item.update(item_params)
      redirect_to merchant_item_path(params[:merchant_id], item.id)
      flash[:notice] = "#{item.name} updated successfully"
    else
      redirect_to edit_merchant_item_path(params[:merchant_id], item.id)
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    item = Item.new(item_params)
      if item.save
        redirect_to merchant_items_path(params[:merchant_id])
      else
        redirect_to new_merchant_items_path(params[:merchant_id])
        flash[:notice] = "Error: all requested areas must be filled!"
      end
  end

  private

  def item_params
    params.permit(:id, :name, :unit_price, :description, :enabled, :merchant_id)
  end
end
