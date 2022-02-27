class Admin::DashboardController < ApplicationController
  def index
    @customers = Customer.top_five_customers
    require "pry"; binding.pry
    @invoices = Invoice.not_shipped
    # @invoices = InvoiceItem.not_shipped
  end
end
