class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all.order(:id)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice.update(invoice_items_params)
    redirect_to admin_invoice_path(invoice)
  end

  private
  def invoice_items_params
    params.permit(:status)
  end
end
