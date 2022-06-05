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
    if params[:update_status_to] == "disabled"
      merchant.disabled!
       redirect_to "/admin/merchants"
    elsif params[:update_status_to] == "enabled"
      merchant.enabled!
       redirect_to "/admin/merchants"
    else
      merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to "/admin/merchants/#{merchant.id}"
    flash[:notice] = 'Merchant Successfully Updated'
   end
  end

 private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end