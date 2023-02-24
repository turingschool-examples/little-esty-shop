class AdminController < ApplicationController
  def index
    @incomplete_invoices = Invoice.incomplete_invoices
    @top_five_customers = Customer.top_five_customers
  end
end