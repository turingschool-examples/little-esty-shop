class ItemsController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :edit, :update]
  before_action :find_item, only: [:show, :edit, :update]
  
  def index
    @merchant
  end
  
  def show
    @merchant
    @item
  end

  def edit
    @merchant
    @item
  end


  def update
    if params[:status_change]
      @item.update(status: params[:status_change])
      redirect_to merchant_items_path(@merchant)
    elsif @item.update(item_params)
      flash[:notice] = "Your item has been successfully updated"
      redirect_to merchant_item_path(@merchant, @item)
    else
      flash[:notice] = "ERROR: Missing required information"
      redirect_to edit_merchant_item_path(@merchant, @item)
    end
  end
  
  private
  def item_params
    params.permit(:name, :description, :unit_price)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_item
    @item = Item.find(params[:id])
  end
end