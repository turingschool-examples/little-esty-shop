class AdminController < ApplicationController
  def dashboard
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
    @top_customers = Customer.top_five_customers
    @incomplete_invoices = Invoice.incomplete
  end
end