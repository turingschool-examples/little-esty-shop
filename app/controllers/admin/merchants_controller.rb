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
    if merchant.update(merchants_params)
      redirect_to "/admin/merchants/#{merchant.id}"
      flash[:alert] = "Merchant Successfully updated!"
    else
      redirect_to "/admin/merchants/#{merchant.id}/edit"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end
  
  # def destroy
    
  # end

private
  def merchants_params
    params.require(:merchant).permit(:name)
  end
end