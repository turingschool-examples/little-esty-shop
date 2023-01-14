class Merchant::DiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.new(discount_params)

    if discount.save
      redirect_to merchant_discounts_path(merchant)
    else
      redirect_to new_merchant_discount_path(merchant)
      flash[:error] = "Fill in all areas before creating"
    end
  end

  private

  def discount_params
    params.permit(:merchant_id, :name, :threshold, :percentage)
  end
end