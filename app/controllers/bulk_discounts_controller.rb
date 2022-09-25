class BulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.new
  end

  def create
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = @merchant.bulk_discounts.new(bulk_discount_params)
    if @bulk_discount.save 
      flash.notice = "Bulk Discount ID #{@bulk_discount.id} Successfully Created"
      redirect_to(merchant_bulk_discounts_path(@merchant))
    else
      flash.alert = @bulk_discount.errors.full_messages.to_sentence
      render :new
    end
  end

  private
  def bulk_discount_params
    params.require(:bulk_discount).permit(:discount, :threshold)
  end
end