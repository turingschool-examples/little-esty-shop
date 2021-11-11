class AdminMerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def new
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def create
    Merchant.create(merchant_params)
    redirect_to admin_merchants_path
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:change_status]
      merchant.change_status
      redirect_to admin_merchants_path
    else
      merchant.update(merchant_params)
      redirect_to admin_merchants_show_path
      flash.alert = 'Information updated successfully' 
    end
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
