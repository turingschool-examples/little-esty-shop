class Admin::DashboardController < ApplicationController
  def index
    @top_5 = Customer.top_5
  end
end 