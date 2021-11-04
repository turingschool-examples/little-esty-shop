class AdminController < ApplicationController
  def index
    @top_customers = Customer.top_customers
    @pending_invoices = Invoice.pending_invoices
  end
end