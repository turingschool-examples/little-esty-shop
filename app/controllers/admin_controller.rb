class AdminController < ApplicationController
  def index
    @top_5_customers = Customer.top_5_customers_by_successful_transactions
  end
end