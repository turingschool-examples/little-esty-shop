class AdminController < ApplicationController
  def index
    @top_5_customers = Customer.top_5_transactions
    @incomplete_ids = Invoice.find_unshipped
  end
end