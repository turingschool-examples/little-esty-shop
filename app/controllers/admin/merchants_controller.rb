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
    merchant = Merchant.find(params[:id])
    if params[:merchant][:status] == "enabled"
      merchant.update(status: "enabled")
      redirect_to "/admin/merchants"
    elsif params[:merchant][:status] == "disabled"
      merchant.update(status: "disabled")
      redirect_to "/admin/merchants"
    elsif merchant.update(merchant_params)
      redirect_to "/admin/merchants/#{merchant.id}"
      flash[:alert] = "Successfully Updated Item"
    else
      redirect_to "/admin/merchants/#{merchant.id}/edit"
      flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

private
  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end
