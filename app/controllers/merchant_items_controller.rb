class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @enabled_items = @merchant.enabled_items
    @disabled_items = @merchant.disabled_items
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if merchant_item_params[:commit] == "Disable"
      @item.update(status: merchant_item_params[:status])
      redirect_to "/merchants/#{@item.merchant_id}/items"
    elsif merchant_item_params[:commit] == "Enable"
      @item.update(status: merchant_item_params[:status])
      redirect_to "/merchants/#{@item.merchant_id}/items"
    else
      @item.update(name: merchant_item_params[:item_name],description: merchant_item_params[:item_description],unit_price: merchant_item_params[:unit_price])

      redirect_to "/merchants/#{merchant_item_params[:merchant_id]}/items/#{params[:id]}", notice: "Item information updated!"
    end

  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])

    item = merchant.items.create(name: merchant_item_params[:item_name], description: merchant_item_params[:item_description], unit_price: merchant_item_params[:unit_price])

    if item.save
      # this should be HAPPY path
      # but right now BOTH happy and sad paths hit this
      redirect_to "/merchants/#{merchant.id}/items", notice: "#{merchant_item_params[:item_name]} created!"
    else
      # this should be SAD path
      # but right now NEITHER happy nor sad paths hit this
      redirect_to "/merchants/#{merchant.id}/items/new", notice: "Error - please complete all fields"
    end

  end

  private

  def merchant_item_params
    params.permit(:item_name, :item_description, :unit_price, :merchant_id, :commit, :status, :item_id)
  end
end
