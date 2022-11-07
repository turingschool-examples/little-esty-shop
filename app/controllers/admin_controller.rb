class AdminController < ApplicationController
  def index
    @top_customers = Customer.top_5_by_successful_transactions
    @incomplete_invoice_items = InvoiceItem.not_shipped
  end
end
