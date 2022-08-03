class MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)

    redirect_to "/admin/merchants/#{@merchant.id}", notice: "Information successfully updated!" 
  end


  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end

