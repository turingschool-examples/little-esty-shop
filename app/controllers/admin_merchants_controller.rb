class AdminMerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    # binding.pry
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end
  
  def update 
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to "/admin/merchants/#{merchant.id}"
    flash[:notice] = 'Merchant Successfully Updated'
  end

  private
    def merchant_params
      params.require(:merchant).permit(:name)
    end
end
