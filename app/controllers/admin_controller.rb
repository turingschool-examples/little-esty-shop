class AdminController < ApplicationController
  def index 
    @incomplete_invoices = Invoice.incomplete_invoices
    @top_customers = Customer.top_customers
  end
end