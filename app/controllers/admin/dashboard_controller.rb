class Admin::DashboardController < ApplicationController
  def index
    @unshipped_invoices = Invoice.unshipped
    @top_5_customers = Customer.top_5_customers
  end
end
