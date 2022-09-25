class BulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @discounts = @merchant.bulk_discounts
    # require "pry"; binding.pry
  end

  def show
    # require "pry"; binding.pry
    # @discount = BulkDiscount.find(params[:id])
  end

end
