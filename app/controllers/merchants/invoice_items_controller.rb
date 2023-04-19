class Merchants::InvoiceItemsController < ApplicationController
  def update
    merchant = Merchant.find(params[:invoice_item][:merchant_id])
    invoice = Invoice.find(params[:invoice_item][:invoice_id])
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(invoice_items_params)
    redirect_to merchant_invoice_path(merchant, invoice)
  end

  private
  def invoice_items_params
    params.require(:invoice_item).permit(:status)
  end
end