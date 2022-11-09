class Admin::InvoicesController < ApplicationController
  def show
    @invoice = Invoice.find(params[:id])
    @customer = @invoice.customer
    @total_revenue = @invoice.admin_total_revenue
  end

  def index
    @invoices = Invoice.all
  end
end
