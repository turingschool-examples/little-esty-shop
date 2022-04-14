class AdminController < ApplicationController
  def index
    @customers = Customer.top_five_customers
    @invoices = Invoice.pending_invoices
  end

end
