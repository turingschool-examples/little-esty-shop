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
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    flash[:success] = 'Merchant updated'
    redirect_to admin_merchant_path(merchant)
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      redirect_to admin_merchants_path
    else
      flash[:alert] = 'Error! Please try again'
      redirect_to new_admin_merchant_path
    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
