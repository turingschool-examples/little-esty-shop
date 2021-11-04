class AdminController < ApplicationController
  def index
    @top_customers = Customer.top_customers
  end
end