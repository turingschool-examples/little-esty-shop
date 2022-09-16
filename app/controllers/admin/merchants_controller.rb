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

  def new
  end

  def create
    merchant = Merchant.new(merchant_params)

    if merchant.save
      redirect_to  "/admin/merchants"
    end
  end

  def update
    merchant = Merchant.find(params[:id])
    #merchant.update(merchant_params)
    #redirect_to admin_merchant_path(merchant.id)
    #binding.pry
    if params.has_key?(:status)
      merchant.update(merchant_params)
      redirect_to admin_merchants_path
    else
      merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}"
      flash[:message] = "You've successfully updated your information"
    end
  end


private

  def merchant_params
    params.permit(:name, :created_at, :updated_at, :status)
  end

end
