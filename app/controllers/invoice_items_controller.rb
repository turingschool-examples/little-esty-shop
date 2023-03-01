class InvoiceItemsController < ApplicationController
  def update
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(status: params[:status])
 
    redirect_to "/merchants/#{invoice_item.item.merchant.id}/invoices/#{invoice_item.invoice.id}"
  end
end