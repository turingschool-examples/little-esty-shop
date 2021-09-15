class Merchants::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    # @items = @merchant.items
  end
end
