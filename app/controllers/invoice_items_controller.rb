class InvoiceItemsController < ApplicationController
  def update
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice_item.update(status: params[:invoice_item_status])
    redirect_to merchant_invoice_path(@invoice_item.item.merchant_id, @invoice_item.invoice_id)
  end
end