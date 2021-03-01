class Admin::DashboardController < ApplicationController
  def index
    # require "pry";binding.pry
    @top_five_customers = Customer.top_five_customers
    @invoice_items = InvoiceItem.all
    # require "pry";binding.pry
    @invoices = Invoice.all
    # @formatted_created_at = Invoice.find(params[:id]).format_time
  end

  # def show
  #
  # end
end
