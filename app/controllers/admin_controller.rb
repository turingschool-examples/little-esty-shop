class AdminController < ApplicationController
  def index
    @top_five_customers = Customer.top_five_customers
    @incomplete_item_invoices = InvoiceItem.incomplete_item_invoices
  end
end