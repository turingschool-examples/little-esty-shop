class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def edit
  end

  def update
    invoice = Invoice.find(params[:id])
    if params['invoice']['status'] == 'cancelled'
      invoice.update(status: 0)
      redirect_to admin_invoice_path(invoice.id)
    elsif params['invoice']['status'] == 'completed'
      invoice.update(status: 1)
      redirect_to admin_invoice_path(invoice.id)
    elsif params['invoice']['status'] == 'in progress'
      invoice.update(status: 2)
      redirect_to admin_invoice_path(invoice.id)
    end
  end
end
