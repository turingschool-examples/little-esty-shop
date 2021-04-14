class MerchantsController < ApplicationController

  def welcome
  end

  def show
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
