class Admin::MerchantsController < ApplicationController
  #reason to have 2 merchant controllers -- encapsulates methods within the Admin realm in a separate controller
 	def index
	  @merchants = Merchant.all
	end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    @merchant = Merchant.create(merchant_params)
    redirect_to "/admin/merchants"
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params[:disable]
       merchant.update(status: params[:disable].to_i)
      redirect_to "/admin/merchants"
    elsif params[:enable]
      merchant.update(status: params[:enable].to_i)
      redirect_to "/admin/merchants"
    else
      merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}"
      flash[:notice] = "Successfully Updated Merchant Information"
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end
