class Admin::DashboardController < ApplicationController
  def index
    @incomplete_invoices = Invoice.order_by_oldest
  end
end
