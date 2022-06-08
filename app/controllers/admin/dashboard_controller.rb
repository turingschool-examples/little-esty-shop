class Admin::DashboardController < ApplicationController

  def index
    @invoices = Invoice.oldest_first
    @top_cust = Customer.top_customers
  end
end
