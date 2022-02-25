class Merchant::MerchantsController < ApplicationController

  def update
    merchant = Merchant.find(params[:id])
    if merchant.name != params[:merchant][:name]
      merchant.update!(merchant_params)
      redirect_to admin_merchant_path(merchant)
      flash[:notice] = "#{merchant.name} has been updated"
    else
      redirect_to admin_merchant_path(merchant)
    end
  end

  private
    def merchant_params
      params.require(:merchant).permit(:name)
    end
end
