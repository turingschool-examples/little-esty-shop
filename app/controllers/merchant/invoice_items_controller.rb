class Merchant::InvoiceItemsController < ApplicationController
  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice = Invoice.find(params[:invoice_id])
    item = Item.find(params[:item_id])
    
    invoice_item = InvoiceItem.find_by(invoice_id: invoice.id, item_id: item.id)
    invoice_item.update(status: params[:status])
    
    redirect_to merchant_invoice_path(merchant, invoice)
  end
end