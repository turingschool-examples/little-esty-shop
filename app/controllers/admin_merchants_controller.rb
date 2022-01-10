class AdminMerchantsController < ApplicationController
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
    redirect_to "/admin/merchants/#{merchant.id}",  notice: "Merchant Successfully Updated"
  end

  def new

  end

  def create
    merchant = Merchant.create!(merchant_params)
    redirect_to "admin/merchants"
  end

  private

  def merchant_params
    params.permit(:name, :status)
  end

end
