class AdminController < ApplicationController
  def index
    @incomplete_invoice_items = InvoiceItem.incomplete_invoices
  end
end