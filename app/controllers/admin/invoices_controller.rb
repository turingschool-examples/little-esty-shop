class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all.order(id: :asc)
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_customer = @invoice.customer
    @items = @invoice.items
    @invoice_items = @invoice.invoice_items
  end

  def update
    invoice = Invoice.find(params[:id])
    if invoice.update(invoice_params)
      redirect_to "/admin/invoices/#{invoice.id}"
    end
  end

  private

  def invoice_params
    params[:status] = params[:status].to_i
    params.permit(:id, :status)
  end
end
