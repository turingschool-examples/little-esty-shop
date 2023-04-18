class Admin::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
    @app_logo = PhotoBuilder.app_photo_info
  end

  def show
    @invoice = Invoice.find(params[:id])
    @items = @invoice.items
    @invoice_items = @invoice.invoice_items
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update(status: params[:invoice_status])
    redirect_to admin_invoice_path(@invoice)
  end
end