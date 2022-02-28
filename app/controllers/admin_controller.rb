class AdminController < ApplicationController
  def show
    # repo_name
    @customers = Customer.all
    @invoices = Invoice.all
  end
end
