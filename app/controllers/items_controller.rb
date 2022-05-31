class ItemsController < ApplicationController
  before_action :find_merchant, only: [:index]

  def index
    @items = @merchant.items
  end

  def show
    @item = Item.find(params[:id])
  end
end
