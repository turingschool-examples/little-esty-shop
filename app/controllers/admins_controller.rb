class AdminsController < ApplicationController
  def dashboard
    @customers = Customer.all
    @invoices = Invoice.all
  end
end
