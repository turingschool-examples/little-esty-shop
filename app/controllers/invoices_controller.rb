class InvoicesController < ApplicationController
  def update
    invoice = Invoice.find(params[:id])
    status = params[:status]
    invoice.update(status: status)
    redirect_to admin_invoice_path(invoice)
  end
end