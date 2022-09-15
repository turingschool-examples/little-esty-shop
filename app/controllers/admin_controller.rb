class AdminController < ApplicationController
  def index
    @top_customers = Customer.top_five_customers
    @inc_invoices = InvoiceItem.incomplete_invoices
  end
end
