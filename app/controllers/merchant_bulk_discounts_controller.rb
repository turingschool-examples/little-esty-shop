class MerchantBulkDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.bulk_discounts.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end


  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = @merchant.bulk_discounts.new(discount_params)
    if discount.save
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      flash[:alert] = "Error: All fields must be filled out"
      redirect_to new_merchant_bulk_discount_path(merchant)
    end
  end
    def destroy
      merchant = Merchant.find(params[:merchant_id])
      discount = BulkDiscount.find(params[:id])
      discount.destroy
      redirect_to merchant_bulk_discounts_path(merchant)

    end
  end

private
  def discount_params
    params.permit(:threshold, :discount_percentage)

  end
