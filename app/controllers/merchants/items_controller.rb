class Merchants::ItemsController < ApplicationController
  def index
    @items = Merchant.find(params[:merchant_id]).items
  end
end