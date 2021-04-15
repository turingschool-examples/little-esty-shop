class Admin::DashboardController < ApplicationController

  def index
    @customers = Customer.top_five_customers
  end
end
