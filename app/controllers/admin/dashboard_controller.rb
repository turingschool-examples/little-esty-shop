class Admin::DashboardController < ApplicationController
  def index
    # binding.pry
    @top_5_customers = Customer.top_5_customers
    # binding.pry
  end
end
