class AdminsController < ApplicationController
  def dashboard
    @customers = Customer.top_customers(5)
    @incomplete_invoices = Invoice.incomplete_invoices
  end
end
