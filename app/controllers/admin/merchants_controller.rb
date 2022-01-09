class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(admin_merchant_params[:id])
  end

  def new 
    merchant = Merchant.new
  end

  def create 
    merchant = Merchant.new(admin_merchant_params)
    if merchant.save
      redirect_to "/admin/merchants"
    else
      redirect_to "/admin/merchants/new"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

  def edit
    @merchant = Merchant.find(admin_merchant_params[:id])
  end

private 

  def admin_merchant_params
    params.permit(:id, :name)
  end

end
