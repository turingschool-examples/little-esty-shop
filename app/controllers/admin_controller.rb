class AdminController < ApplicationController
  def dashboard
    @top_customers = Customer.top_five_customers
    @incomplete_invoices = Invoice.incomplete
  end
end