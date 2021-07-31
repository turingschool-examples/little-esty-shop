class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
  
  # def new
    
  # end
  
  # def create
    
  # end
  
  def edit
    @merchant = Merchant.find(params[:id])
  end
  
  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchants_params)
    redirect_to "/admin/merchants/#{merchant.id}"
  end
  
  # def destroy
    
  # end

private
  def merchants_params
    params.require(:merchant).permit(:name)
  end
end