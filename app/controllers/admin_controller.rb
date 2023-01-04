class AdminController < ApplicationController
  def index
    @top_5_customers = Customer.top_5_transactions
    @incomplete_invoices = Invoice.find_unshipped.sort_by_created_date
  end
end