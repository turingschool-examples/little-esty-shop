class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
    @merchant = @item.merchant
  end

  def edit
    @item = Item.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.items.new(item_params)

    if merchant.save
      redirect_to merchant_items_path(merchant)
      flash[:notice] = "Item successfully created!"
    else
      redirect_to new_merchant_item_path(merchant)
      flash[:alert] = "Error: Please fill in all fields."
    end
  end

  # Will need to update to handle edge case of improper unit_price entry
  # at a later date
  # e.g. Typing in as float (3.50) instead of integer (350)
  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if params[:status]
      redirect_to merchant_items_path(item.merchant)
    elsif (params[:name].blank? || params[:unit_price].blank? || params[:description].blank?)
      redirect_to edit_merchant_item_path(item.merchant, item), alert: "Error: Please fill in all fields."
    else
      flash[:notice] = "Item successfully updated!"
      redirect_to merchant_item_path(item.merchant, item)
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
