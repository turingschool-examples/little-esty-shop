class InvoiceItemsController < ApplicationController
  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.change_status(params[:status])
    redirect_to "/merchant/#{merchant.id}/invoices/#{invoice_item.invoice.id}"
  end
end