class BulkDiscountsController < ApplicationController
  def index 
    @merchant = Merchant.find(params[:merchant_id])
  end 

  def show 

  end 

  def new 
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.new
  end 

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.create(discount_params)
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  private
  def discount_params
    params.require(:bulk_discount).permit(:percentage_discount, :quantity)
  end
end 