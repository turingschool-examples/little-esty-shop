class AdminController < ApplicationController
  def index
    @top_five_customers = Customer.five_top_customers
    @not_shipped_invoices = Invoice.not_shipped_invoices
  end
end
