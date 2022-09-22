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

  def create
    @bulk_discount = @merchant.bulk_discounts.create!(percentage_discount: params["percentage_discount"], quantity_threshold: params["quantity"])

    redirect_to(merchant_bulk_discounts_path(@merchant))
  end
  

end