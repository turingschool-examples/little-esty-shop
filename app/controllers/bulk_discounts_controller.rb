class BulkDiscountsController < ApplicationController
  before_action :do_merchant

  def index
    @bulk_discounts = @merchant.bulk_discounts
  end

  def show
    @bulk_discount = BulkDiscount.find(params[:id])
  end

  def new
    @bulk_discount = BulkDiscount.new
  end

  def create
    bulk_discount = @merchant.bulk_discounts.create(bulk_discount_params)
    if bulk_discount.save
      redirect_to merchant_bulk_discounts_path(@merchant)
    else
      flash[:alert] = "Please fill out entire form before submitting"
      redirect_to new_merchant_bulk_discount_path(@merchant)
    end
  end

  def destroy
    bulk_discount = BulkDiscount.find(params[:id])
    bulk_discount.destroy
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private
    def do_merchant
      @merchant = Merchant.find(params[:merchant_id])
    end

    def bulk_discount_params
      params.permit(:name, :percent_off, :threshold)
    end
end
