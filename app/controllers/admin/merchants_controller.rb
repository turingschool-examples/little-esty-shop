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
  
  # def update
    
  # end
  
  # def destroy
    
  # end

private
  def _params
    params.require(:merchant).permit(:name)
  end
end