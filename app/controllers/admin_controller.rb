class AdminController < ApplicationController
  def index
    @customers = Customer.top_five_customers
    @invoices = Invoice.pending_invoices
    @merchants = Merchant.top_5_merchants
  end

end
