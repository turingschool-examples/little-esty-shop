class MerchantItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
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
