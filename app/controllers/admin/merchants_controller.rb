class Admin::MerchantsController < ApplicationController 
  def show
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchants = Merchant.all
    @top_merchants = Merchant.top_5_by_revenue
  end

  def create 
    merchant = Merchant.new(merchant_create_params)
    merchant.save
    redirect_to admin_merchants_path
  end
#  New private merchant params method duplicate of merchant params, broke create method as previously method used 'merchant_params' and now seems to need a reference to an existing merchant to create a merchant. Changed the name of mechant params to merchant create params below and referenced it in create. Prob temp fix as we only need one params method?
  def merchant_create_params
    params.permit(:name)
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end
  
  def new
    @merchant = Merchant.new
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to admin_merchant_path(merchant.id), notice: "Merchant successfully updated!"
  end

  private
    def merchant_params
      params.require(:merchant).permit(:name, :status)
    end
end