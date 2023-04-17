class InvoiceItemsController < ApplicationController
  def update
    invoice_item = InvoiceItem.find(params[:id])

    invoice_item.update(invoice_item_params)

    redirect_to merchant_invoice_path(invoice_item.merchant, invoice_item.invoice)
  end

private

  def invoice_item_params
    params.require(:invoice_item).permit(:status)
  end
end