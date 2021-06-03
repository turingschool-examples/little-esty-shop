class Admin::DashboardController < ApplicationController

  def index
    @top_five_customers = Customer.top_five
    @incomplete_invoices = Invoice.filter_by_unshipped_order_by_age
  end
end