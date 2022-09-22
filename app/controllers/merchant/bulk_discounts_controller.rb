class Merchant::BulkDiscountsController < Merchant::BaseController

  def index
#merchant is being set in the base controller
@discounts = @merchant.bulk_discounts
  end

end