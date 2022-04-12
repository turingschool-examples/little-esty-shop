class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:id])
  end

  def create

    merch_id = params[:id].to_i
    merchant = Merchant.find(merch_id)
    item = merchant.items.create!(item_params)
    if item.save
    redirect_to "/merchants/#{merchant.id}/items"
    end
  end

    private
      def item_params
        params.permit(:id, :name, :description, :unit_price, :status, :created_at, :updated_at)
      end
end
