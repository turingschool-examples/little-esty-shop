class MerchantsController < ApplicationController

  def welcome
  end

  def show
    @merchant = Merchant.find(params[:id])
    @top_five = @merchant.top_five_customers
    @ship_ready = @merchant.ship_ready
  end

  def index
    @merchants = Merchant.all
  end

  def item_index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items.all
  end

  def item_show
  end

  def invoice_index
  end

  def invoice_show
  end

end
