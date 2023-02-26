class MerchantsController < ApplicationController
	
  def dashboard
    @merchant = Merchant.find(params[:id])
    @top_five_customers = @merchant.customers.top_five_customers
    @items_to_ship = @merchant.invoice_items.unshipped_items
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    redirect_to admin_merchant_path(@merchant)
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name)
  end
end