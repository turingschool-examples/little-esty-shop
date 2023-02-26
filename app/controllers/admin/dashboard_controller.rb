class Admin::DashboardController < ApplicationController
  def index
   @top_customers = Customer.customers_transactions
    @incompleted_invoices = Invoice.invoice_items_not_shipped
  end
end