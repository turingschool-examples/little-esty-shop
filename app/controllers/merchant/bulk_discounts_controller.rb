class Merchant::BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @bulk_discount = BulkDiscount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.new(bulk_discount_params)
    if discount.save
      redirect_to merchant_bulk_discounts_path(@merchant.id)
    else
      redirect_to new_merchant_bulk_discount_path(@merchant.id)
      flash[:alert] = "Error: #{error_message(bulk_discount.errors)}"
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:bulk_discount][:merchant_id])
    @discount = BulkDiscount.find(params[:id])
    @discount.update(bulk_discount_params)
    redirect_to merchant_bulk_discount_path(params[:bulk_discount][:merchant_id], params[:bulk_discount][:id])
  end

  def destroy
    @merchant = Merchant.find_by(id: params[:merchant_id])
    BulkDiscount.find(params[:id]).destroy
    redirect_to merchant_bulk_discounts_path(@merchant.id)
    flash[:alert] = "Your discount was deleted"
  end

  private
  def bulk_discount_params
    {
      id: params[:bulk_discount][:id],
      name: params[:bulk_discount][:name],
      percent_discount: params[:bulk_discount][:percent_discount],
      quantity_threshold: params[:bulk_discount][:quantity_threshold],
      merchant_id: params[:bulk_discount][:merchant_id]
    }
  end
end
