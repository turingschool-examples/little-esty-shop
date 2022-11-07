
class Admin::InvoicesController < ApplicationController 
  def index 
    @invoices = Invoice.all
  end

  def show 
    @invoice = Invoice.find(params[:id])
    @customer = @invoice.customer
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.update(status: params[:invoice_status])

    redirect_to admin_invoice_path(invoice)
  end
end