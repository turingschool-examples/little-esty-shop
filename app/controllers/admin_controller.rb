class AdminController < ApplicationController
  def index 
    @incomplete_invoice_items = InvoiceItem.incomplete_invoices
    @top_customers = Customer.top_customers
  end
end