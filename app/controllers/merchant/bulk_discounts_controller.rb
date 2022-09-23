class Merchant::BulkDiscountsController < Merchant::BaseController

  def index
    @discounts = @merchant.bulk_discounts
  end
end