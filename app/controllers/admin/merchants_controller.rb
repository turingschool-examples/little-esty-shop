class Admin::MerchantsController < ApplicationController
  def index
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def new

  end

  def create
    merchant = Merchant.new(admin_merchant_params)
    if merchant.save
      redirect_to admin_merchants_path
    else
      redirect_to new_admin_merchant_path
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

  def update
    @merchant = Merchant.find(params[:id])
    if params[:status]
      @merchant.update(admin_merchant_params)
      redirect_to admin_merchants_path
    elsif @merchant.update(admin_merchant_params)
      redirect_to admin_merchant_path(@merchant)
      flash[:alert] = "Merchant successfully updated"
    else
      redirect_to edit_admin_merchant_path(@merchant)
      flash[:alert] = "Error: #{error_message(@merchant.errors)}"
    end
  end

  private

  def admin_merchant_params
    params.permit(:name, :status)
  end
end