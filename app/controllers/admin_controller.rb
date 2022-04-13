class AdminController < ApplicationController
  def index
    @customers = Customer.all
    @invoices = Invoice.all
  end
end
