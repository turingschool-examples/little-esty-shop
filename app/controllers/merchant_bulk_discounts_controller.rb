class MerchantBulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    discount = BulkDiscount.new(discount_params)
    
    if discount.save
      redirect_to merchant_bulk_discounts_path(params[:merchant_id])
    else
      redirect_to new_merchant_bulk_discount_path(params[:merchant_id])
      # binding.pry
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
  end

  private
  def discount_params
    params.permit(:merchant_id, :percentage, :quantity_threshold)
  end
end