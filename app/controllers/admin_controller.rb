class AdminController < ApplicationController
  def dashboard
    @top_customers = Customer.top_five_customers
  end
end