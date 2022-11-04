class AdminController < ApplicationController
  def index
    @customers = Customer.top_customers
    @incomplete_invoices = Invoice.incomplete_invoices
  end
end
