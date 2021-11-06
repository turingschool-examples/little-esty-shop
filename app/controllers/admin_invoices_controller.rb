class AdminInvoicesController < ApplicationController

  def index
    @invoices = Invoice.all
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
    @customer = Customer.find(@invoice.customer_id)
    @invoice_items = InvoiceItem.find(params[:invoice_id])
    @item = Item.find(@invoice_items.item_id)
  end
end
