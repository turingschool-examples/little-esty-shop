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
    if params[:name].gsub(' ', '') == ""
      flash[:notice] = 'Empty name not permitted. Please try again.'
      redirect_to edit_admin_merchant_path(@merchant)
    else
      @merchant.update(merchant_params)
      flash[:notice] = 'Merchant has been successfully updated.'
      redirect_to admin_merchant_path(@merchant)
    end
  end

  private
  def merchant_params
    params.permit(:name)
  end
end