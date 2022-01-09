class MerchantsController < ApplicationController

  def index
    
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  # def update
  #   merchant = Merchant.find(params[:id])

  #   if merchant.update(merchant_params)
  #     flash[:success] = merchant.name + ' was successfully updated.'
  #     redirect_to admin_merchant_path(params[:id])
  #   else
  #     flash[:alert] = "Error: #{error_message(merchant.errors)}"
  #   end 
  # end

end
