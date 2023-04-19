class Admin::MerchantsController < ApplicationController
  def index
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
    @top_five_merchants = Merchant.top_five_merchants
    @app_logo = PhotoBuilder.app_photo_info
  end

  def show
    @merchant = Merchant.find(params[:id])
    @photo = PhotoBuilder.merchant_photo_info
    @app_logo = PhotoBuilder.app_photo_info
  end

  def edit
    @merchant = Merchant.find(params[:id])
    @app_logo = PhotoBuilder.app_photo_info
  end

  def new
    @merchant = Merchant.new
    @app_logo = PhotoBuilder.app_photo_info
  end

  def create
    Merchant.create(admin_merchant_params)
    redirect_to admin_merchants_path 
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(admin_merchant_params)
    if !params[:merchant][:status].nil?
      redirect_to admin_merchants_path
    else
      flash[:alert] = "This Merchant's information has been updated"
      redirect_to admin_merchant_path(@merchant)
    end
  end

  private
  def admin_merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end