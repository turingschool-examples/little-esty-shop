class Admin::DashboardController < ApplicationController

  def index
    @customers = Customer.top_five_customers
    @invoices = Invoice.incomplete_invoices
  end
end
