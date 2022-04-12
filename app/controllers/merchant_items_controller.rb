class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:id])
  end

  def new
  end

  def update
  end

  def create
  end

  def update
  end

  def destroy
  end
end
