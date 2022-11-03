class AdminController < ApplicationController 
  def index
    @merchants = Merchant.all
    @five_best_customers = Customer.top_five_total_customers
  end
end