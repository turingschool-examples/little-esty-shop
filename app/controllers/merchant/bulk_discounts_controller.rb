class Merchant::BulkDiscountsController < Merchant::BaseController

  def index
#merchant is being set in the base controller
@discounts = @merchant.bulk_discounts
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new

  end

end