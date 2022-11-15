class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @holiday_names = HolidayService.holiday_name
    @holiday_dates = HolidayService.holiday_date
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @discount = BulkDiscount.new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.new(bulk_discount_params)
    if discount.save
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      redirect_to new_merchant_bulk_discount_path(merchant)
      flash[:alert] = "Error! Please enter a valid discount."
    end
  end

  def destroy
    discount = BulkDiscount.find(params[:id])
    discount.destroy
    redirect_to merchant_bulk_discounts_path(discount.merchant)
  end

  def edit
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    discount = BulkDiscount.find(params[:id])
    if discount.update(bulk_discount_params)
      redirect_to merchant_bulk_discount_path(discount.merchant, discount)
    else
      redirect_to edit_merchant_bulk_discount_path(discount.merchant, discount)
      flash[:alert] = "Error! Please update fields with content"
    end
  end

  private

  def bulk_discount_params
    params.permit(:percentage, :quantity_threshold)
  end
end