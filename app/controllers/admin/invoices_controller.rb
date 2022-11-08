class Admin::InvoicesController < ApplicationController
  def show
    @invoice = Invoice.find(params[:id])
    @customer = @invoice.customer
  end

  def index
    @invoices = Invoice.all
  end
end