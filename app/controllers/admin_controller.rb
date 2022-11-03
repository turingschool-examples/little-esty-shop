class AdminController < ApplicationController
  def index
     @invoice_items = InvoiceItem.incomplete_invoices
  end
end