class Merchant::BulkDiscountsController < Merchant::BaseController

  def index
    @discounts = @merchant.bulk_discounts
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @new_discount = @merchant.bulk_discounts.new
  end

  def create
    new_discount = @merchant.bulk_discounts.new(bulk_discount_params)
    new_discount.save
    flash.notice = "New Discount Added"
    redirect_to merchant_bulk_discounts_path(@merchant)
  end

  private

  def bulk_discount_params
    params.require(:bulk_discount).permit(
      :discount_percent, 
      :quantity_threshold
    )
  end
end