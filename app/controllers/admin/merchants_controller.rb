class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def new
    
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])

    if params[:id]
      if params[:status]
        @merchant.change_status
        redirect_to admin_merchants_path
      else
        @merchant.update(merchant_params)
        redirect_to admin_merchant_path(@merchant)
        flash[:notice] = "Merchant successfully updated."
      end
    else

    end
  end


  private

  def merchant_params
    params.permit(:name)
  end
end