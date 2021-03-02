class Admin::DashboardController < ApplicationController
  def index
    @top_five_customers = Customer.top_five_customers
    @invoice_items = InvoiceItem.all
  end
end
