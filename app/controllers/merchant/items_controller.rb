class Merchant::ItemsController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :new, :create, :edit, :update, :destroy, :toggle_item]
  before_action :find_item, only: [:show, :edit, :update, :destroy, :toggle_item]

  def index
  end

  def show
    @photo = PhotoSearch.new.search_result(@item.name)
  end

  def new
    @item = Item.new
  end

  def create
    item = Item.new(item_params.merge(merchant_id: @merchant.id))
    if item.save
      redirect_to merchant_items_path(@merchant.id), notice: "Item successfully saved!"
    else
      flash.now[:alert] = "Error: #{error_message(item.errors)}"
      render :new
    end
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
    @item.update(is_enabled: !@item.is_enabled)
    redirect_to merchant_items_path(@merchant.id), notice: "Item successfully #{@item.is_enabled ? 'enabled' : 'disabled'}!"
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
end
