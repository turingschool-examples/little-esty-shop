class Admin::MerchantsController < ApplicationController
  def index
    @top_5 = Merchant.find_top_5
    @enabled_merchants = Merchant.all_enabled
    @disabled_merchants = Merchant.all_disabled
  end

  def new

  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end
end