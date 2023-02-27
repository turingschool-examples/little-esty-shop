class AdminController < ActionController::Base
  def index
    # require 'pry'; binding.pry
    @top_5_customers = Customer.top_5_successful_customers
    @invoices_not_shipped = Invoice.incomplete_invoices
  end
end