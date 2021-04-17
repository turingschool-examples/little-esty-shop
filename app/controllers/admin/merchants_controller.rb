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
    # binding.pry
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    if @merchant.save
      redirect_to admin_merchant_path(@merchant)
      flash[:success] = 'Merchant successfully updated!'
    end
  end

  private

   def merchant_params
     params.require(:merchant).permit(:name)
   end

end
