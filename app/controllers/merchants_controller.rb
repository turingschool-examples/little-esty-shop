class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:id])
    @items = Item.not_shipped(@merchant.id)
    @top_customers = Customer.top_customers(@merchant.id)
  end

  def index
    @merchants = Merchant.alphabetically
  end
end
