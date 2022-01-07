class Admin::BaseController < ApplicationController

  def index
    @invoices = Invoice.all
    @customers = Customer.all
  end
end
