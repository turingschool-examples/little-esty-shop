class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @top_5_merchants = Merchant.top_five_merchants_by_revenue
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
end