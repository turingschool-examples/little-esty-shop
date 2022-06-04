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
    # @item = Item.create
  end

  private

  def item_params
    # binding.pry
    params.require(:item).permit(
      :name,
      :description,
      :status,
      unit_price: params[:unit_price].to_f / 100.0
    )
  end
end
