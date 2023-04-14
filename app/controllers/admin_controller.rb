class AdminController < ApplicationController
  def index
    @customers = Customer.top_customers
    @invoices = Invoice.order(created_at: :asc)
  end
end