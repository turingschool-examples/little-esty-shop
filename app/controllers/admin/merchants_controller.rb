class Admin::MerchantsController < ApplicationController
  def index
    @all_merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(admin_merchant_params)
      redirect_to admin_merchant_path(@merchant)
      flash[:alert] = "Merchant successfully updated"
    else
      redirect_to edit_admin_merchant_path(@merchant)
      flash[:alert] = "Error: #{error_message(@merchant.errors)}"
    end
  end

  private

  def admin_merchant_params
    params.permit(:name)
  end
end