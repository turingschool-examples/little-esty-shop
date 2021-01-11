class Admin::MerchantsController < ApplicationController
  def index
    @enabled_merchants = Merchant.where(enabled: true)
    @disabled_merchants = Merchant.where(enabled: false)
    @top_merchants = Merchant.top_merchants(5)
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.update(merchant_params)
      flash.notice = "Successfully Updated Info"
      if params[:name]
        destination = admin_merchant_path(params[:id])
      else
        destination = admin_merchants_path
      end
      redirect_to destination
    else
      flash.alert = merchant.errors.full_messages
      @merchant = merchant
      render "edit"
    end
  end

  def new
  end

  def create
    merchant = Merchant.new(merchant_params.merge(enabled: false))
    if merchant.save
      flash.notice = "Successfully Added Merchant"
      redirect_to admin_merchants_path
    else
      flash.alert = merchant.errors.full_messages
      render "new"
    end
  end

  private

  def merchant_params
    params.permit(:name, :enabled)
  end
end
