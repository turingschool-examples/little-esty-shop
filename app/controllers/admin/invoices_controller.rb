class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    new_invoice_status = Invoice.find(params[:id])
    new_invoice_status.update(status: params[:status])
    redirect_to "/admin/invoices/#{new_invoice_status.id}"
  end

end
