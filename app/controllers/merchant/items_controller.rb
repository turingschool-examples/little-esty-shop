class Merchant::ItemsController < ApplicationController

def index
  # require "pry"; binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_enabled = @merchant.enabled_status
    @merchant_disabled = @merchant.disabled_status
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
      params.permit(:name, :description, :unit_price, :item_status)
    end
end
