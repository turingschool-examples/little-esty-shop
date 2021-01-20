class MerchantDiscountsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.discounts
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    @discount = Merchant.find(params[:merchant_id]).discounts.create(
      discount_params
    )
     redirect_to merchant_discounts_path(@discount.merchant)
  end
   # @discount = Merchant.find(params[:merchant_id]).discounts.new(discount_params)
   #  if @discount.save
   #    redirect_to merchant_discounts_path(@discount.merchant)
   #  else
   #    flash.notice = "Discount Information Incorrect, please try again."
   #    redirect_to merchant_discounts_path(@discount.merchant)
   #  end
  # end

  def destroy
    Discount.destroy(params[:id])
    redirect_to merchant_discounts_path(Merchant.find(params[:merchant_id]))
  end

  def show
    @discount = Merchant.find(params[:merchant_id]).discounts.find(params[:id])
  end

  def edit
    @discount = Discount.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    discount = Discount.find(params[:id])
    discount.update(
      discount_params
    )
    redirect_to merchant_discount_path(discount.merchant, discount)
  end

  private

  def discount_params
    params.permit(:discount_percentage, :quantity_threshold)
    # params.require(:discount).permit(:item_requirement, :percentage_discount)
  end

end
