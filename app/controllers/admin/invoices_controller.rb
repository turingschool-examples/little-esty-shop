class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end
  
  def shows
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update(status: params[:status])
    
    redirect_to admin_invoice_path(@invoice)
  end
end