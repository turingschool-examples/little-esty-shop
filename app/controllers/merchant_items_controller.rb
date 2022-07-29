class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(merchant_item_params[:merchant_id])
    @items = @merchant.items
    @enabled_items = @merchant.enabled_items
    @disabled_items = @merchant.disabled_items
  end

  def show
    @merchant = Merchant.find(merchant_item_params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(merchant_item_params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])

    if params[:commit] == "Disable"
      @item.update(status: merchant_item_params[:status])
      redirect_to "/merchants/#{@item.merchant_id}/items"      
    elsif params[:commit] == "Enable"
      @item.update(status: merchant_item_params[:status])
      redirect_to "/merchants/#{@item.merchant_id}/items"
    else
      @item.update(name: merchant_item_params[:name],description: merchant_item_params[:description],unit_price: merchant_item_params[:unit_price])

      redirect_to "/merchants/#{merchant_item_params[:merchant_id]}/items/#{params[:id]}", notice: "Item information updated!"
    end

  end

  def new
    @merchant = Merchant.find(merchant_item_params[:merchant_id])
  end

  def create
    if params[:item_description] != "" && params[:item_name] != "" && params[:unit_price] != nil
      
      item = Item.create(
        name: params[:item_name],
        description: params[:item_description],
        unit_price: params[:unit_price],
        merchant_id: params[:merchant_id]
      )

      redirect_to "/merchants/#{params[:merchant_id]}/items", notice: "#{params[:item_name]} created!"
    else
      flash[:notice] = "Error - please complete all fields"
      
      redirect_to "/merchants/#{params[:merchant_id]}/items/new"
    end

  end

  private
  def merchant_item_params
    params.permit(:name, :description, :unit_price, :merchant_id, :status,)
  end
end
