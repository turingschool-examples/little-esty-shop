class Admin::DashboardController < ApplicationController
  def index
   @top_customers = Customer.customers_transactions
    @unshipped = InvoiceItem.not_shipped
  end
end