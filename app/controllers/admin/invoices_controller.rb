class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def edit
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    if params[:update_to] == 'cancelled'
      invoice.update(status: 0)
      redirect_to admin_invoice_path(invoice.id)
    elsif params[:update_to] == 'completed'
      invoice.update(status: 1)
      redirect_to admin_invoice_path(invoice.id)
    elsif params[:update_to] == 'in progress'
      invoice.update(status: 2)
      redirect_to admin_invoice_path(invoice.id)
    end
  end
end
