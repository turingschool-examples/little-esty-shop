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

    if params[:status] = false
      merchant.update(merchant_params)
      redirect_to admin_merchant_path(merchant.id)
    else
      merchant.update(merchant_params)
      flash[:message] = "You've successfully updated your information"

    end
  end


private

  def merchant_params
    params.permit(:name, :created_at, :updated_at)
  end

end
