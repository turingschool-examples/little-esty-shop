class Merchants::InvoiceItemsController < ApplicationController
  def update
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice_item.update(status_param)

    redirect_to merchant_invoice_path(@invoice_item.merchants[0].id, @invoice_item.invoice.id)
  end

  private

  def status_param
    params.require(:invoice_item).permit(:status)
  end
end
