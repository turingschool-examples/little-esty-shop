class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.where(params[:enabled] = 'true')
    @disabled_merchants = Merchant.where('enabled = false', params[:enabled])
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if params[:name]
      @merchant.update(name: params[:name])
      redirect_to admin_merchant_path
    else
      @merchant.toggle(:enabled).save
      redirect_to admin_merchants_path
    end
  end
end