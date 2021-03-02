class Admin::MerchantsController < ApplicationController
  def index
    @admin_merchants = Merchant.all
  end

  def show
    @admin_merchant = Merchant.find(params[:id])
  end

  def edit
    @admin_merchant = Merchant.find(params[:id])
  end

  def update
    @admin_merchant = Merchant.find(params[:id])
    if admin_merchant_params[:status]
      @admin_merchant.update(admin_merchant_params)
      if @admin_merchant.status == true
        @admin_merchant.status = false
      else
        @admin_merchant.status = true
      end
      @admin_merchant.save
      redirect_to admin_merchants_path
    else @admin_merchant.update(admin_merchant_params)
      flash[:notice] = "The information has been successfully updated."
      @admin_merchant.save
      redirect_to admin_merchant_path(@admin_merchant)
    end
  end

  private
  def admin_merchant_params
    params.permit(:name, :status)
  end
end
