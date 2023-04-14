class AdminController < ApplicationController
  def index
    @customers = Customer.top_customers
    @invoices = Invoice.all
  end
end