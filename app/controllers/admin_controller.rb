class AdminController < ActionController::Base
  def index
    @top_5_customers = Customer.top_5_successful_customers
    @invoice_ids_not_shipped = InvoiceItem.incomplete_invoices
  end
end