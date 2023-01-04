class AdminController < ApplicationController
  def index
    @top_customers = Customer.top_5_customers
  end
end