class Admin::DashboardController < ApplicationController

  def index
    @incomplete_invoices = Invoice.incomplete_invoices
    @customers = Customer.top_five
  end
end
