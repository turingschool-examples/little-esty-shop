class CustomerController < ApplicationController
  def index
    @admin_customers = Customer.all
  end
end
