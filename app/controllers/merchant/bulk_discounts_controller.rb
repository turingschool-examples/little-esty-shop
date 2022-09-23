class Merchant::BulkDiscountsController < Merchant::BaseController

  def index
#merchant is being set in the base controller
@discounts = @merchant.bulk_discounts
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new
#merchant is being set in the base controller
  end

  def create
    #merchant is being set in the base controller
    @bulk_discount = @merchant.bulk_discounts.create!(percentage_discount: params["percentage_discount"], quantity_threshold: params["quantity"])

    redirect_to(merchant_bulk_discounts_path(@merchant))
  end

  def destroy
      BulkDiscount.find(params[:id]).destroy
      redirect_to "/merchants/#{params[:merchant_id]}/bulk_discounts"
  end
  
  def edit
    @discount = BulkDiscount.find(params[:id])
    # require 'pry' ; binding.pry
  end

end