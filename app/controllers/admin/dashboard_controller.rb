class Admin::DashboardController < ApplicationController
  def index
    @invoices = Invoice.all
    @top_5_customers = Customer.top_5_customers
  end
end
