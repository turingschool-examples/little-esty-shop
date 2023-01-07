class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @top_five_merchants = Merchant.top_five_merchants
  end

  def new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    @merchant.save
    redirect_to admin_merchants_path
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