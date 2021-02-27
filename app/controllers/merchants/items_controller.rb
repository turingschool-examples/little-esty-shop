class Merchants::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update]

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params) && !params[:status]
      flash[:notice] = "Item Succesfully Updated"
      redirect_to merchant_item_path(@item.merchant, @item)
    elsif !@item.update(item_params)
      flash[:notice] = "Required Information Missing"
      redirect_to edit_merchant_item_path(@item.merchant, @item)
    elsif params[:status] == "disable"
      @item.disable_item
      flash[:notice] = "#{@item.name} Disabled"
      redirect_to merchant_items_path(@item.merchant)
    elsif params[:status] == "enable"
      @item.enable_item
      flash[:notice] = "#{@item.name} Enabled"
      redirect_to merchant_items_path(@item.merchant)
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price)
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
