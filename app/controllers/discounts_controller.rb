class DiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
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
    @merchant = Merchant.find(params[:merchant_id])
    @discount = @merchant.discounts.new(discount_params)
    if @discount.save
      redirect_to(merchant_discounts_path(@merchant))
    else
      flash.alert = @discount.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @discount = Discount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:id])
    discount.update(discount_params)
    redirect_to(merchant_discount_path(merchant, discount))
  end

  def destroy
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id]).destroy
    redirect_to(merchant_discounts_path(@merchant))
  end

  private
  def discount_params
    params.require(:discount).permit(:bulk_discount, :item_threshold)
  end
end
