class InvoiceItemsController < ApplicationController
  def update
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(invoice_item_params)
    # redirect_to merchant_invoice_item_path(params[:merchant_id], params[:id])
    redirect_to "/merchants/#{merchant.id}/invoice/#{invoice.id}"
  end

  private

  def invoice_item_params
    params.require(:invoice_item).permit(:id, :status)
  end
end