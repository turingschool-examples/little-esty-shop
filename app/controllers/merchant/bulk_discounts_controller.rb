class Merchant::BulkDiscountsController < Merchant::BaseController

  def index
    @discounts = @merchant.bulk_discounts
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end
end