class AdminController < ApplicationController
  def index
    @top_five_customers = Customer.top_five_customers
    # @incomplete_item_invoices = InvoiceItem.incomplete_item_invoices
    @incomplete_invoices = Invoice.incomplete_invoices
  end
end