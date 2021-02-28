class AdminController < ApplicationController

  def index
    @top_five_customers = Customer.top_five
    @incomplete_invoices = Invoice.incomplete.ordered_by_dated
  end
end
