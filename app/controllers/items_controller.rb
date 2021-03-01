class ItemsController < ApplicationController
  before_action :set_item, except: [:index, :new, :create]
  before_action :set_merchant

  def index
  end

  def show
  end

  def edit
  end

  def update
    if item_params[:status]
      @item.update!(item_params)
      redirect_to merchant_items_path(params[:merchant_id])
    else @item.update!(item_params)
      flash[:notice] = "Item successfully updated"
      redirect_to merchant_item_path(@item.merchant_id, @item.id)
    end
  end

  def new
    @item = Item.new
  end

  def create
    @merchant.items.create!(item_params)
    redirect_to merchant_items_path(params[:merchant_id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :status)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
