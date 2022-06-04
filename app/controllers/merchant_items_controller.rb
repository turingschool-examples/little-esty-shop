class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    # binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    # binding.pry
    item = Item.find(params[:id])
    if params[:item][:status]
      item.update(status: params[:item][:status])
      redirect_to "/merchants/#{merchant.id}/items"
    else
      item.update(item_params)
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}", notice: 'Item Successfully Updated'
    end
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.new
  end

  def create
    # binding.pry
    merchant = Merchant.find(params[:merchant_id])
    @item = merchant.items.create!(item_params)
    redirect_to merchant_items_path(merchant.id)
  end

  private

  def item_params
    # binding.pry
    params.require(:item).permit(
      :name,
      :description,
      :status,
      :unit_price
    )
  end
end
