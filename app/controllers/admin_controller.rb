class AdminController < ActionController::Base
  def index
    @top_5_customers = Customer.top_5_successful_customers
  end
end