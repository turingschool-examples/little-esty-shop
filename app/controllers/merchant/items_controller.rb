class Merchant::ItemsController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :edit, :update, :destroy, :toggle_item]
  before_action :find_item, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to merchant_item_path(@merchant, @item), notice: "Item successfully updated!"
    else
      flash.now[:alert] = "Error: #{error_message(@item.errors)}"
      render :edit
    end
  end

  def toggle_item
    item = Item.find(toggle_item_params[:item])
    if item.update(enabled: !item.enabled)
      flash.now[:notice] = "Item successfully #{item.enabled ? 'enabled' : 'disabled'}!"
    end
    render :index
  end

  private

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_item
    @item = @merchant.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end

  def toggle_item_params
    params.permit(:item)
  end
end
