class InvoiceItemsController < ApplicationController
  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice_item = InvoiceItem.find(params[:id])
    invoice = invoice_item.invoice
    invoice_item.update(invoice_items_params)
    redirect_to merchant_invoice_path(merchant, invoice)
  end

private
  def invoice_items_params
    params.require(:invoice_item).permit(:status, :id)
  end
end
