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
    if params[:status]
      enable_disable_logic
    elsif @merchant.update(merchant_params) && !params[:status]
      flash[:notice] = "Merchant Updated Successfully"
      redirect_to admin_merchant_path(@merchant)
    end
  end

  private

  def enable_disable_logic
    if params[:status] == "enable"
      @merchant.enable_merchant
      flash[:notice] = "#{@merchant.name} Enabled"
      redirect_to admin_merchants_path
    else
      @merchant.disable_merchant
      flash[:notice] = "#{@merchant.name} Disabled"
      redirect_to admin_merchants_path
    end
  end

   def merchant_params
     params.require(:merchant).permit(:name)
   end

end
