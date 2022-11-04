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
    if params[:status]
      @merchant.update(merchant_params)
      redirect_to "/admin/merchants"
    else
      @merchant.update(merchant_params)
      flash[:notice] = "Successfully Updated: #{@merchant.name}"
      redirect_to "/admin/merchants/#{@merchant.id}"
    end
  end

  def new
  end

  def create
    @merchant = Merchant.create!(merchant_params)
    redirect_to "/admin/merchants"
  end


private
  def merchant_params
    params.permit(:name, :status)
  end
end
