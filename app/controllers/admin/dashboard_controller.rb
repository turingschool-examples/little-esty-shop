class Admin::DashboardController < ApplicationController
  def index
    @top_5 = Customer.top_5
    @incomplete_invoices = Invoice.incomplete_invoices.order_by_created_at_old_to_new
  end
end
