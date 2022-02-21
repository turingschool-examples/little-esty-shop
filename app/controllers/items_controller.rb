class ItemsController < ApplicationController
  def create
    Item.create(item_params)
  end

  

  private
    def item_params
      params.permit(:name, :description, :unit_price, :item_status)
    end
end
