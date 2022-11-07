class AdminController < ApplicationController
  def index
    @top_customers = Customer.top_5_by_successful_transactions
  end
end
