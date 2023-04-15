class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if merchant.update(merchant_params)
      redirect_to admin_merchant_path(merchant)
      flash[:success] = "Information has been successfully updated"
    else
      redirect_to edit_admin_merchant_path(merchant)
      flash[:alert] = "Error: #{merchant.errors.full_messages.to_sentence}"
    end
  end

  private
  def merchant_params
    params.require(:merchant).permit(:name)
  end

end