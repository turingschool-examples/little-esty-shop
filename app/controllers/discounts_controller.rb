class DiscountsController < ApplicationController

  def index
    @discounts = Discount.where(merchant_id: params[:merchant_id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @discount = Discount.find(params[:discount_id])
    @merchant = Merchant.find(params[:merchant_id])

  end

  def edit
    @discount = Discount.find(params[:discount_id])
  end

  def update
    discount = Discount.find(params[:discount_id])
    discount.update(discount_params)
    redirect_to action: :show
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    Discount.create(min_quantity: params[:min_quantity], percent_off: params[:percent_off], merchant_id: params[:merchant_id])
    redirect_to action: :index
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    discount = Discount.find(params[:discount_id])
    discount.destroy
    # redirect_to action: :index
    redirect_to action: :index

  end

  private

  def discount_params
    params.permit(:min_quantity, :percent_off)
  end

end
