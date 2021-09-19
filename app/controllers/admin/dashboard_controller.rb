class Admin::DashboardController < ApplicationController
  def index
    @incomplete_invoices = Invoice.order_by_oldest
    @five_best_customers = Customer.five_best_customers
  end
end
