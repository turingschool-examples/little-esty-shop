class DiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.new
  end

  def create
    discount = Discount.new(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(params[:merchant_id])
    else
      redirect_to new_merchant_discount_path(params[:merchant_id])
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end

  def update
    discount = Discount.find(params[:id])
    if discount.update(discount_params)
      redirect_to merchant_discount_path(params[:merchant_id], params[:id])
    else
      redirect_to edit_merchant_discount_path(params[:merchant_id], params[:id])
      flash[:alert] = "Error: #{error_message(discount.errors)}"
    end
  end

  def destroy
    Discount.destroy(params[:id])
    redirect_to merchant_discounts_path(params[:merchant_id])
  end

  private
  def discount_params
    params.permit(:id, :quantity_threshold, :percentage_discount, :merchant_id)
  end

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end