class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
    # require "pry"; binding.pry
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    BulkDiscount.create(discount_params)
    redirect_to merchant_bulk_discounts_path
  end

  def destroy
    @discount = BulkDiscount.find(params[:id])
    @discount.destroy
    redirect_to merchant_bulk_discounts_path
  end

end

private

def discount_params
  params.permit(:threshold, :discount, :merchant_id)
end
