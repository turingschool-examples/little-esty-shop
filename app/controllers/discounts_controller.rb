class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end
  def show 
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end
  def create 
    @merchant = Merchant.find(params[:merchant_id])
    Discount.create!(merchant_id: @merchant.id, quantity_threshhold: params[:quantity_threshhold], percentage: params[:percentage])
    redirect_to "/merchants/#{@merchant.id}/discounts"
  end
  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    Discount.destroy(params[:id])
    redirect_to "/merchants/#{@merchant.id}/discounts"
  end
end
