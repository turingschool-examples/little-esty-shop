class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all

    @top_5_merchants = Merchant.top_5_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

end