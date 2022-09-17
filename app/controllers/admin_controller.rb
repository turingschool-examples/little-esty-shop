class AdminController < ApplicationController

  def index
    @top_5_customers = Customer.top_five_overall_cust
    @incomplete_invoices = Invoice.incomplete_invoices_sorted
  end

end