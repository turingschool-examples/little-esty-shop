class ItemsController < ApplicationController
  # before_action :do_merchant, except: [:update, :destroy]

  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    # require "pry"
    # binding.pry
    @item = Item.find(params[:id])
  end
end
