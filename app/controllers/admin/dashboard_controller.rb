class Admin::DashboardController < ApplicationController
  def index
    @invoices = Invoice.all
    @customers = Customer.all
  end
end