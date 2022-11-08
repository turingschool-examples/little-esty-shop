class AdminController < ApplicationController
  def index
    @top_customers = Customer.top_5_by_successful_transactions
    @incomplete_invoice_items = InvoiceItem.not_shipped.sort_by_invoice_creation_date
  end
end
