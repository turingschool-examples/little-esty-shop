class ItemsController < ApplicationController
  before_action :find_merchant

  def index
    @items = @merchant.items
  end

  def new

  end

  def create
    require 'pry'; binding.pry
    item = Item.new(item_params)
    if item.save
    redirect_to "/merchants/#{@merchant.id}/items"
    end
  end

    private
      def item_params
        params.permit(:id, :name, :description, :unit_price, :merchant_id, :status)
      end
end
