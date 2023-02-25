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
    @merchant.update(merchant_params)
    if @merchant.save
      flash[:notice] = "#{@merchant.name} Information has been Updated"
      if params[:merchant][:status]
        redirect_to admin_merchants_path
      else
        redirect_to admin_merchant_path(@merchant)
      end
    else
      flash[:notice] = "Unable to Update - Missing Information"
      redirect_to edit_admin_merchant_path(@merchant)
    end

  end

  private
  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end