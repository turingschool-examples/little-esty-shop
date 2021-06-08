class InvoiceItemsController < ApplicationController

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice_item = InvoiceItem.find(params[:id])
    @invoice = @invoice_item.invoice
    @invoice_item.update!({
      :status => InvoiceItem.statuses[params[:status]]
    })
    redirect_to("/merchants/#{@merchant.id}/invoices/#{@invoice.id}")
  end

end
