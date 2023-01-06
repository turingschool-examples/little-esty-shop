class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.toggle_status if params[:status].present?
    
    redirect_to admin_merchants_path
  end
end