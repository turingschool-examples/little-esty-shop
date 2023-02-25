class AdminController < ApplicationController
  def index
    @customers = Customer.top_five_customers
    @incomplete_invoices = Invoice.invoice_items_not_shipped
  end
end