class Merchant::ItemsController < ApplicationController
  before_action :set_item, only: [ :show, :edit, :update ]

  def index
    @merchant = Merchant.find(params[:merchant_id])
    if params[:sort] == 'name'
      @items = @merchant.items.order_by_name(:name)
    elsif params[:sort] == 'date'
      @items = @merchant.items.order_by_date(:updated_at, :desc)
    else
      @items = @merchant.items
    end
    @enabled_items = @merchant.items.enabled_items
    @disabled_items = @merchant.items.disabled_items
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to merchant_items_path(params[:merchant_id])
      flash[:notice] = "#{@item.name} successfully Created."
    else
      redirect_to new_merchant_item_path(params[:merchant_id])
      flash[:alert] = "All fields are required."
    end
  end

  def update
    @item.update(item_model_params)
    return redirect_back(fallback_location: merchant_items_path(@item.merchant_id)) if params[:direct] == 'enable'
    redirect_to merchant_item_path(@item.merchant_id, @item.id), notice: "Item successfully updated."
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.permit(:name, :description, :unit_price, :enable, :merchant_id)
  end

  def item_model_params
    params.require(:item).permit(:name, :description, :unit_price, :enable)
  end
end
