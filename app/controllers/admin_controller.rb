class AdminController < ApplicationController
  def index
    @incomplete_invoices = Invoice.find_all_invoices_not_shipped
    @top_five_customers = Customer.top_five
  end
end