class ItemsController < ApplicationController
  before_action :set_item
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
  end

  def edit
  end

  def update
    if @item.update!(item_params)
      flash[:success] = "Item successfully updated"
      redirect_to merchant_item_path(@item.merchant_id, @item.id)
    else
      flash.now[:notice] = "Error, try again."
      render edit, action: @item
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
