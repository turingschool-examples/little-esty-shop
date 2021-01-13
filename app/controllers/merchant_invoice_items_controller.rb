class MerchantInvoiceItemsController < ApplicationController
  def update
    invoiceItem = InvoiceItem.find(params[:id])
    invoiceItem.update!(invoice_item_params)
    redirect_to "/merchants/#{invoiceItem.invoice.merchant.id}/invoices/#{invoiceItem.invoice.id}"
  end

  private

  def invoice_item_params
    params.require(:invoice_item).permit(:status)
  end
end
