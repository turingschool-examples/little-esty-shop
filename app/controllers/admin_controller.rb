class AdminController < ApplicationController
  def show
    @invoices = Invoice.all
    @customers = Customer.all
  end
end
