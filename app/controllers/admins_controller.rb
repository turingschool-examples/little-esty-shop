class AdminsController < ApplicationController
  def dashboard
    @customers = Customer.top_customers(5)
  end
end