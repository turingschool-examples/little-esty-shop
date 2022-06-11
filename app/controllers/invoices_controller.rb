class InvoicesController < ApplicationController
  before_action :find_merchant

  def index
    @invoices = Invoice.invoices_with_merchant_items(@merchant)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice = Invoice.find(params[:id])
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update(invoice_item_params)
    redirect_to merchant_invoice_path(@merchant, invoice)
  end

  private
  def invoice_item_params
    params.permit(:status)
  end
end
