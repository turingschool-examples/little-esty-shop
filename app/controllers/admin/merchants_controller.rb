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
    @merchant.update(merchant_params)
    @merchant.update(status: params[:disable].to_i) if params[:disable]
    @merchant.update(status: params[:enable].to_i) if params[:enable]

    flash[:success] = 'Merchant updated'
    redirection 
    # redirect_to admin_merchant_path(@merchant)
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
    params.permit(:name)
  end

  def redirection
    if params[:disable] || params[:enable]
      redirect_to admin_merchants_path
      else
      redirect_to admin_merchant_path(@merchant)
    end
  end
end
