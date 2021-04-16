class Admin::MerchantController < ApplicationController

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
      if @merchant.update!(merchant_params)
          flash[:message] = "Information has been successfully updated. #{error_message(@merchant.errors)}"
        redirect_to "/admin/merchant/#{@merchant.id}"
      else
        flash[:error] = "Please fill in all fields. #{error_message(@merchant.errors)}."
        redirect_to "/admin/merchant/#{@merchant.id}/edit"
      end
    end

  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end
end
