class MerchantsController < ApplicationController
  # before_action
  def show
     #contributors
    @merchant = Merchant.find(params[:id])
  end

  def update
    # binding.pry
    merchant = Merchant.find(params[:id])
    merchant.update(name: params[:merchant][:name])
    flash[:notice] = "Merchant Successfully Updated."
    redirect_to "/admin/merchants/#{merchant.id}"
  end
end
