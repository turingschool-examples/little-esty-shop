class Admin::DashboardController < ApplicationController
  def index
    @top5 = Customer.top_5_customers_by_transactions
    @incomp_invoices = Invoice.incomplete_invoices
  end
end
