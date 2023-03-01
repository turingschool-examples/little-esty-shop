class Merchants::InvoiceItemsController < ApplicationController
  
  def update
    @invoice_item = InvoiceItem.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @invoice_item.invoice
    @invoice_item.update!(invoice_items_params)
    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end

  private

  def invoice_items_params
    params.permit(:quantity, :unit_price, :status, :item_id, :invoice_id)
  end
end