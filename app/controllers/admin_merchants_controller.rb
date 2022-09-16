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

  def new
  end

  def create
    merchant = Merchant.create(merchant_params)
    redirect_to "/admin/merchants"
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:status]
      merchant.update(merchant_params)
      redirect_to "/admin/merchants"
    else
      merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}", notice: "Update to #{merchant.name} was successful!"
    end
  end

private
  def merchant_params
    params.permit(:name, :status)
  end

end