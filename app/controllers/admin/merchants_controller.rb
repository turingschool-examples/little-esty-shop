class Admin:: MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    merchant = Merchant.new(merchant_params)

    if merchant.save
      redirect_to admin_merchants_path
    else
      redirect_to new_admin_merchant_path
      flash[:alert] = "Error: Field Cannot Be Left Blank"
    end
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to admin_merchant_path(merchant)
    flash[:alert] = "YOUR MERCHANT HAS BEEN UPDATED."
  end

  def update_status
    merchant = Merchant.find(params[:id])
    if params[:status] == true
      merchant.disable
    elsif params[:status] == false
      merchant.enable
    else
      merchant.update(status: params[:status])
    end

    redirect_to "/admin/merchants"
  end



  private
  def merchant_params
    params.permit(:name, :status)
  end
end
