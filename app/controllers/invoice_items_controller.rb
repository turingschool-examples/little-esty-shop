class InvoiceItemsController < ApplicationController
  def update
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice_item.update(invoice_item_params)
    flash[:success] = "#{@invoice_item.item.name} status successfully updated."
    redirect_to merchant_invoice_path(@invoice_item.merchant.id, @invoice_item.invoice.id)
  end

  private

  def invoice_item_params
    params.require(:invoice_item).permit(:status)
  end
end