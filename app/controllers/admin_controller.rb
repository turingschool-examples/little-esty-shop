class AdminController < ApplicationController
  def index
    @incomplete_invoices = Invoice.all_incomplete_invoices
    @top_five_customers = Customer.top_five
  end
end