class AdminMerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def new
  end

  def create
    Merchant.create(merchant_params)
    redirect_to admin_merchants_path
  end

  private

  def merchant_params
    params.permit(:name)
  end
end