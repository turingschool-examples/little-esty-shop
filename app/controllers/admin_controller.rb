class AdminController < ApplicationController
  def index
    @top_customers = Customer.top_customers
    @incomplete_invoices = Invoice.incomplete
  end
end