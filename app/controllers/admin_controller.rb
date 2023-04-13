class AdminController < ApplicationController

  def index
    @customers = Customer.top_5_by_transactions
    @invoices = Invoice.find_and_sort_incomplete_invoices
  end
end
