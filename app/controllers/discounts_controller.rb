# name all facades get_...
# name all services find_...

class DiscountsController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :new, :create, :edit, :update, :destroy]

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

  def edit
    @discount = Discount.find(params[:id])
    # @discount = Discount.find_by(merchant_id: params[:merchant_id], id: params[:id])
    # require "pry"; binding.pry
  end

  def update
    discount = Discount.find_by(merchant_id: params[:merchant_id], id: params[:id])
    discount.update(discount_params)
    redirect_to merchant_discount_path(@merchant, discount)
  end
  # if params[:status]
  #   @item.update(item_status_params)
  #   redirect_to merchant_items_path
  # else
  #   if @item.update(item_params)
  #     flash[:message] = 'You have successfully updated this item!'
  #     redirect_to merchant_item_path(@merchant, @item)
  #   else
  #     flash[:message] = 'Please fill out all fields to update this item!'
  #     # render :new not sure why this doesn't work here
  #     redirect_to edit_merchant_item_path(@merchant, @item)
  #   end
  # end

  def destroy
    Discount.find_by(merchant_id: params[:merchant_id], id: params[:id]).destroy
    redirect_to merchant_discounts_path(@merchant)
  end

  private
  def discount_params
    params.permit(:percentage, :quantity_threshold)
  end
end
