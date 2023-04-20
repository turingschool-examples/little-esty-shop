class Merchants::ItemsController < ApplicationController
  def index
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
  end

  def show
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @images = @image_search.images(@item.name)
  end

  def edit
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    if item_params[:status].present?
      @item.update(item_params)
      redirect_to merchant_items_path(@item.merchant)
    elsif @item.update(item_params)
      flash[:success] = 'Item Updated'
      redirect_to merchant_item_path(@item.merchant, @item)
    else
      flash[:notice] = 'Item Update Failed'
      redirect_to edit_merchant_item_path(@item.merchant, @item)
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.new(item_params)
    if @item.save
      flash[:created] = 'Item Created'
      redirect_to merchant_items_path(@merchant)
    else
      flash[:failed] = 'Item Creation Failed'
      redirect_to new_merchant_item_path(@merchant)
    end
  end

  private
  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end