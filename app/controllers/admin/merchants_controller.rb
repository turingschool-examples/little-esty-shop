class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.where('enabled = true', params[:enabled])
    @disabled_merchants = Merchant.where('enabled = false', params[:enabled])

    @top_5_merchants = Merchant.top_5_revenue
  end

  def new
  end

  def create
    merchant = Merchant.new(name: params[:name], enabled: false)
    if merchant.save
      redirect_to admin_merchants_path
      flash[:alert] = "Creation successful"
    else
      redirect_to new_admin_merchant_path
      flash[:alert] = "Error: Parameter Missing"
    end
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