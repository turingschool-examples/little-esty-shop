class Admin::InvoicesController < ApplicationController

  def index 
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
    @total_revenue = @invoice.invoice_items.invoice_total_revenue
  end
end
 