class Admin::DashboardController < ApplicationController
  def index
    @top5 = Customer.top_5_customers_by_transactions
  end
end
