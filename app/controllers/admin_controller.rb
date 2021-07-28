class AdminController < ApplicationController

  def index
    @customers = Customer.top_customers
  end
end
