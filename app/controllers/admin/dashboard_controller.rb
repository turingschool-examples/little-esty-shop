class Admin::DashboardController < ApplicationController
  def index
    # require "pry";binding.pry
    @top_five_customers = Customer.top_five_customers
    @invoice_items = InvoiceItem.all
  end

  # def show
  #
  # end
end
