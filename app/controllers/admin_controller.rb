class AdminController < ApplicationController

  def index
    @customers = Customer.top_5_by_transactions
    @invoices = Invoice.find_incomplete_invoices
  end
end
