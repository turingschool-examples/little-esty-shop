class AdminController < ApplicationController
  def index
    @top_5_customers = Customer.top_5_customers_by_successful_transactions
    @incomplete_invoices = Invoice.incomplete_invoices.order(:created_at)
  end
end