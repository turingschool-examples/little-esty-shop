class Merchant::InvoiceItemsController < ApplicationController
  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice = merchant.invoices.find(params[:id])
    invoice_item = InvoiceItem.find(params[:invoice_item_id]) 

    invoice_item.update(status: params[:status])
    redirect_to "/merchants/#{merchant.id}/invoices/#{invoice.id}"
  end
end