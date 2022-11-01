class MerchantDashboardsController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @merchant_customers = @merchant.customers_distinct
    @merchant_transaction_id_array = @merchant.merchant_successful_transaction_ids
    # binding.pry
  end
end