class ItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if !params[:enable].nil?
      item = Item.find(params[:enable])
      # require "pry"; binding.pry
      item.update(status: 1)
    end
    redirect_to "/merchants/#{@merchant.id}/items"
    # require "pry"; binding.pry
  end
end
