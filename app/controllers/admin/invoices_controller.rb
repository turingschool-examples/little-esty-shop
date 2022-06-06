class Admin::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update(invoice_item_params)
    redirect_to admin_invoice_path(invoice)
  end

  private
    def invoice_item_params
      params.permit(:status)
    end
end
