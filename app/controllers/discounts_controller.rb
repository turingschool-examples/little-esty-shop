# name all facades get_...
# name all services find_...

class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :new, :create, :destroy]

  def index
    @discounts = Discount.all
    @holidays = HolidayFacade.get_holidays
  end

  def show
    @discount = Discount.find(params[:id])
  end

  def new
  end

  def create
    @merchant.discounts.create!(discount_params)
    redirect_to merchant_discounts_path(@merchant)
  end

  def destroy
    Discount.find_by(merchant_id: params[:merchant_id], id: params[:id]).destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  private
  def discount_params
    params.permit(:percentage, :quantity_threshold)
  end
end
