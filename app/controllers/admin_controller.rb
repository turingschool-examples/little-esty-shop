class AdminController < ApplicationController 
  def index
    @merchants = Merchant.all
    @five_best_customers = Customer.top_five_total_customers
    @incomplete_invoices = Invoice.incomplete_invoices
  end
end