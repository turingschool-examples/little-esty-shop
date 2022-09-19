class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if params[:name] && params[:name].gsub(' ', '') == ""
      flash[:notice] = 'Empty name not permitted. Please try again.'
      redirect_to edit_admin_merchant_path(@merchant)
    elsif params[:name]
      @merchant.update(merchant_params)
      flash[:notice] = 'Merchant has been successfully updated.'
      redirect_to admin_merchant_path(@merchant)
    elsif params[:enabled]
      @merchant.update(merchant_params)
      redirect_to admin_merchants_path
    end
  end

  private
  def merchant_params
    params.permit(:name, :enabled)
  end
end