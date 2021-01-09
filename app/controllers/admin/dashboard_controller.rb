class Admin::DashboardController < ApplicationController
  def index
    @top_five_customers = Customer.top_five_customers
    @incomplete_invoices = Invoice.incomplete_invoices
  end
end