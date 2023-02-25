class Admin::InvoicesController < ApplicationController

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items_and_attributes = @invoice.items_with_invoice_attributes
  end

  def index
    @invoices = Invoice.all
  end
end