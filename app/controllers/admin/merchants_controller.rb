class Admin::MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
  end
  
  def index
    @merchants = Merchant.all
  end

  def edit
    @merchant = Merchant.find(params[:id])
    flash[:notice] = "Successfully Updated: #{@merchant.name}"
    redirect_to "/admin/merchants/#{@merchant.id}"
  end

end