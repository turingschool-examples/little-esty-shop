class Merchant::ItemsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_items = @merchant.merchant_items  #helper method for item specific to merchant
  end

  def show
    #merchant specific item
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end
end
