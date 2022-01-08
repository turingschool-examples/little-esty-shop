class InvoiceItemsController < ApplicationController
  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(invoice_item_params)

    redirect_to merchant_invoice_path(merchant, invoice_item.invoice)
  end


  private
    def invoice_item_params
      params.require(:invoice_item).permit(:item_id, :invoice_id, :quantity, :unit_price, :status)
    end
end
