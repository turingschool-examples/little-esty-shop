class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.where(params[:enabled] = 'true')
    @disabled_merchants = Merchant.where('enabled = false', params[:enabled])

    @top_5_merchants = Merchant.top_5_revenue
  end

  def new
  end

  def create
    merchant = Merchant.new(merchant_params)

    if merchant.save
      redirect_to admin_merchants_path
      flash[:alert] = "Creation successful"
    else
      redirect_to new_admin_merchant_path
      flash[:alert] = "Error: #{error_message(shelter.errors)}"
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

  def merchant_params
    params.permit(:id, :name)
  end

end