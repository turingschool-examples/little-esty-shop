class ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merch_id = params[:id].to_i
    merchant = Merchant.find(merch_id)
    item = merchant.items.create!(item_params)
    if item.save
    redirect_to "/merchants/#{merchant.id}/items"
    end
  end

  def show
    @item = Item.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @item = Item.find(params[:id])
    @item.update(item_params)
    flash[:success] = 'You have successfully updated this item'
    redirect_to(merchant_item_path)
  end

    private
      def item_params
        params.permit(:id, :name, :description, :unit_price, :status, :created_at, :updated_at, :merchant_id)
      end
end
