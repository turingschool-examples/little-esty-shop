class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items.all
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
    merchant = Merchant.find(params[:merchant_id])
    item = Item.find(params[:id])
    if params[:item][:status]
      item.update(status: params[:item][:status])
      redirect_to "/merchants/#{merchant.id}/items"
    elsif item.update(item_params)
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}", notice: 'Item Successfully Updated'
    else
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}", notice: 'A Required Field Was Missing; Item Not Updated'
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    @item = merchant.items.create!(item_params)
    redirect_to merchant_items_path(merchant.id)
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :status,
      :unit_price
    )
  end
end
