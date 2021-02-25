class Admin::DashboardController < ApplicationController
  def index
    # require "pry";binding.pry
    @top_five_customers = Customer.top_five_customers
  end
end
