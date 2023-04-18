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

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
     
      redirect_to "/admin/merchants/#{@merchant.id}"
      flash[:notice] = "Successfully Updated"
    else
      redirect_to "/admin/merchants/#{@merchant.id}/edit"
      flash[:notice] = "Field cannot be blank"
    end
  end

  private

  def merchant_params
    params.permit(:id, :name)
  end

end