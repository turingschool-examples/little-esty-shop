class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice_item = InvoiceItem.find_by(invoice_id: invoice.id)
    invoice_item.update(status: params[:update_status])

    redirect_to "/admin/invoices/#{invoice.id}"
  end
end