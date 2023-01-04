class AdminController < ApplicationController
  def index
    @top_5_customers = Customer.top_5_transactions
  end
end