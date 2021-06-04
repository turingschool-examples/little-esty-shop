class AdminController < ApplicationController
  def index
    @top_five_customers = Customer.top_five_by_transaction_success
  end
end
