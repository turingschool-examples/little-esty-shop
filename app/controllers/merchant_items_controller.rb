class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @enabled_items = @merchant.items.enabled_items
    @disabled_items = @merchant.items.disabled_items
		@popular_items = @merchant.items.top_five_most_popular_items
  end

	def new
		@item = Item.new
	end

	def create
		merchant = Merchant.find(params[:merchant_id])
		merchant.items.create!(new_merchant_item_params)
		redirect_to merchant_items_path(merchant)
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
    if params[:status].present?
      item.update(status: params[:status].to_i)
      redirect_to "/merchants/#{merchant.id}/items"
    else
      item.update(merchant_item_params)
      redirect_to "/merchants/#{merchant.id}/items/#{item.id}"
    end
  end
  
  private
  def merchant_item_params
    params.permit(:name, :description, :unit_price)
  end

  def new_merchant_item_params
    params.require(:item).permit(:name, :description, :unit_price)
  end
end