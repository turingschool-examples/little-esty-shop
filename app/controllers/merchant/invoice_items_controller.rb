class Merchant::InvoiceItemsController < ApplicationController

  def update
    merchant = Merchant.find(params[:invoice_item][:merchant_id])
    invoice = Invoice.find(params[:invoice_item][:invoice_id])
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(status: params[:invoice_item][:invoice_item_status])
    redirect_to merchant_invoice_path(merchant,invoice)
  end
end
