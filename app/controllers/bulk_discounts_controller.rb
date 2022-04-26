class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    BulkDiscount.find(params[:id]).update(percentage_discount: bulk_discount_params[:percentage_discount], quantity_threshold: bulk_discount_params[:quantity_threshold], merchant_id: params[:merchant_id])
    
    redirect_to merchant_bulk_discount_path(params[:merchant_id], params[:id])
  end

  def create
    BulkDiscount.create!(percentage_discount: bulk_discount_params[:percentage_discount], quantity_threshold: bulk_discount_params[:quantity_threshold], merchant_id: params[:merchant_id] )
    
    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  def destroy
    BulkDiscount.delete(params[:id])
    redirect_to merchant_bulk_discounts_path(params[:merchant_id])
  end

  private

  def bulk_discount_params
    params.permit(:percentage_discount, :quantity_threshold)
  end
end