class Admin::MerchantsController < ApplicationController
  #reason to have 2 merchant controllers -- encapsulates methods within the Admin realm in a separate controller
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
    redirect_to "/admin/merchants/#{merchant.id}"
    flash[:notice] = "Successfully Updated Merchant Information"
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end
