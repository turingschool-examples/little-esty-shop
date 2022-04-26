class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.create!(percentage_discount: bulk_discount_params[:percentage_discount], quantity_threshold: bulk_discount_params[:quantity_threshold], merchant_id: @merchant.id )
    
    redirect_to merchant_bulk_discounts_path(@merchant.id)
  end

  private

  def bulk_discount_params
    params.permit(:percentage_discount, :quantity_threshold)
  end
end