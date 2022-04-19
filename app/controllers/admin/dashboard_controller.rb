class Admin::DashboardController < ApplicationController
  def index
    @top_5_customers = Customer.top_5_customers
    @invoices = Invoice.all
  end
end
