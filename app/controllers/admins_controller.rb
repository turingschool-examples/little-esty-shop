class AdminsController < ApplicationController
  def dashboard
    @customers = Customer.all
    @top_customers = Customer.top_5.map {|customer| customer.attributes}
    @incomplete_invoices_created_at = Invoice.ordered_incomplete_invoices
  end
end
