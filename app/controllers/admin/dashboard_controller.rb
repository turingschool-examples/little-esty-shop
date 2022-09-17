class Admin::DashboardController < ApplicationController

  def index
    @customers = Customer.top_customers
  end


end
