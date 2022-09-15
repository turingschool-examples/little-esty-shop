class MerchantsController < ApplicationController

  def show
    @merchant = Merchant.find(params[:id])

    @best_customers = Customer.top_5_cust_by_merch(@merchant.id)
    
  end
end
