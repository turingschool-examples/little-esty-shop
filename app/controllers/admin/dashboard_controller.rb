class Admin::DashboardController < ApplicationController
  def index
   @top_customers = Customer.customers_transactions
  end
end