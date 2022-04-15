class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = InvoiceItem.where(invoice_id: @invoice.id)
    @items = @invoice.items
  end

  def update
    @invoice = Invoice.find(params[:id])
    if params[:status]["packaged"]
      @invoice_item = InvoiceItem.find(params[:invoice_item_id])
      @invoice_item.update(status: 'packaged')
    elsif params[:status]["pending"]
      @invoice_item = InvoiceItem.find(params[:invoice_item_id])
      @invoice_item.update(status: 'pending')
    elsif params[:status]["shipped"]
      @invoice_item = InvoiceItem.find(params[:invoice_item_id])
      @invoice_item.update(status: 'shipped')
    end

    redirect_to merchant_invoice_path(params[:merchant_id], @invoice)
  end
end
