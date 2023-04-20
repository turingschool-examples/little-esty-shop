class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    # binding.pry
    invoice = Invoice.find(params[:id])
    invoice.update(invoice_params)
    redirect_to admin_invoice_path(invoice)
  end

  private
  def invoice_params
    params.permit(:status)
  end
end