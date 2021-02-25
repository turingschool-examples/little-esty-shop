class ItemsController < ApplicationController
  before_action :find_merchant, only: [:index, :show]
  before_action :find_item, only: [:show]
  
  def index
    @merchant
  end
  
  def show
    @merchant
    @item
  end
  
  private
  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_item
    @item = Item.find(params[:id])
  end
end