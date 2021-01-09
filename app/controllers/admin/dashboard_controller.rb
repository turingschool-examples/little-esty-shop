class Admin::DashboardController < ApplicationController
  def index
    @customers = Customer.top_customers
    @invoices = InvoiceItem.incomplete_invoices
  end
end