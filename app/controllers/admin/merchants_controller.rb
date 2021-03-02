class Admin::MerchantsController < ApplicationController
  def index
    @admin_merchants = Merchant.all
  end
  def show
    @admin_merchant = Merchant.find(params[:id])
  end
  def edit
    @admin_merchant = Merchant.find(params[:id])
  end
end
