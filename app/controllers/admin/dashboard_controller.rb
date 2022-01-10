class Admin::DashboardController < ApplicationController
  def index
    @top_5 = Customer.top_5
    @incomplete_invoices = Invoice.incomplete_invoices
  end
end
