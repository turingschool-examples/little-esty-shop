class MerchantDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    merchant.discounts.create(threshhold_quantity: params[:threshhold_quantity], discount_percentage: params[:discount_percentage])
    redirect_to "/merchants/#{merchant.id}/discounts"
  end

  def destroy
    discount = Discount.find(params[:discount_id])
    discount.destroy

    redirect_to "/merchants/#{params[:merchant_id]}/discounts"
  end
end
