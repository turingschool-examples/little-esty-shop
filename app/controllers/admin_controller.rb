class AdminController < ApplicationController
  def index
    @top_five_customers = Customer.top_five_by_transaction_success
    @incomplete_invoices = Invoice.ordered_invoices_not_shipped
  end
end
