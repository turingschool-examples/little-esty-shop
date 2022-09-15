class AdminController < ApplicationController
  def index
    @five_top_customers = Customer.top_five_customers_admin
    @not_shipped_invoices = Invoice.not_shipped_invoices
  end
end
