class AdminController < ApplicationController
  def index 
    @incomplete_invoice_items = Invoice.incomplete_invoices
    @top_customers = Customer.top_customers
  end
end