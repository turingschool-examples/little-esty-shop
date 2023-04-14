class Admin::DashboardController < ApplicationController
  def index
    @merchants = Merchant.all
    @top_five_customers = Customer.top_five
  end
end