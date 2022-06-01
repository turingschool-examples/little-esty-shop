class ItemsController < ApplicationController
  before_action :find_merchant, only: [:index, :update]

  def index
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_status_params)
    redirect_to(merchant_items_path)
  end

  private

  def item_status_params
    params.permit(:status)
  end
end
