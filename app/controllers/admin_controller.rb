class AdminController < ApplicationController

  def index
    @top_five_customers = Customer.top_five
    @incomplete_invoices = InvoiceItem.invoices_with_unshipped_items
  end
end