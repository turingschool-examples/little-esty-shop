class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.bulk_discounts.create!(bulk_discount_params)
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  private

  def bulk_discount_params
    params.permit(:percentage, :quantity)
  end
end
