class AdminController < ApplicationController

  def index
    @customers = Customer.top_customers
    @invoices = Invoice.incomplete_invoices
  end
end
