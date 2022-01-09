class AdminController < ApplicationController
  def index
    @invoices = Invoice.all
    @customers = Customer.all
    @merchants = Merchant.all
  end
end
