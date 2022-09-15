class AdminController < ApplicationController
  def index
    @top_five_customers = Customer.top_five_customers_admin
    @not_shipped_invoices = Invoice.not_shipped_invoices
  end
end
