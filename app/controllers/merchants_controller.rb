class MerchantsController < ApplicationController

  def dashboard
    @merchant = Merchant.find(params[:merchant_id]) 
    @mech_unshipped_invoice_items = @merchant.unshipped_items
    @mech_top_5_customers = @merchant.mech_top_5_successful_customers
  end

  def create
 
    merchant = Merchant.new(merchant_params)

    if merchant.save 
       redirect_to admin_merchants_path
    end 
  end

  def merchant_params
    params[:merchant][:status].to_i
    params.require(:merchant).permit(:name, :status)
   
  end

end
