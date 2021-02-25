class Admin::DashboardController < ApplicationController
  def index
    # require "pry";binding.pry
    @admin_customers = Customer.all
  end
end
