class Admin::InvoicesController < ApplicationController

  def index 
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
    @invoice_items = @invoice.invoice_items.all 
  end

  def update 
    @invoice = Invoice.find(params[:invoice_id])
    @invoice.update! status:Invoice.statuses[params[:invoice_status]]
    redirect_to "/admin/invoices/#{@invoice.id}"
  end
end
 