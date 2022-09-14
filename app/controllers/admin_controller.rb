class AdminController < ApplicationController
  def index
    @top_five_customers = Customer.five_top_customers
  end
end
