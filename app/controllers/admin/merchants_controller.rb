class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled
    @disabled_merchants = Merchant.disabled # call these in the view
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:status]
      merchant.update(merchant_status_params)
      redirect_to admin_merchants_path
    else
      if merchant.update(merchant_name_params) # make a merchant status controller for update to avoid nesting conditionals
        flash[:notice] = "You have successfully updated this Merchant!"
        redirect_to admin_merchant_path(merchant)
      else
        flash[:notice] = "Please fill out all fields to update this Merchant!"
        redirect_to edit_admin_merchant_path(merchant)
      end
    end
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.create!(merchant_name_params)
    redirect_to admin_merchants_path
  end

private
  def merchant_name_params
    params.require(:merchant).permit(:name)
  end

  def merchant_status_params
    params.permit(:status)
  end
end
