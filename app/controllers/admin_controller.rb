class AdminController < ApplicationController
  def index
    @customers = Customer.all
    @incomplete_invoices = Invoice.not_shipped
  end
end
