class ItemsController < ApplicationController
  before_action :find_merchant

  def index
    @items = @merchant.items
  end

  def new
    # @merchant = Merchant.find(params[:id])
  end

  def create

    item = Item.create(item_params)
    
    redirect_to "/merchants/#{@merchant.id}/items"

  end

    private
      def item_params
        params.permit(:id, :name, :description, :unit_price, :merchant_id, :status)
      end
end
