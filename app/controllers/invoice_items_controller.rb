class InvoiceItemsController < ApplicationController


  def update
    @invoice_items = InvoiceItem.find(params[:id])
    @merchant = @invoice_items.item.merchant
    @invoice = Invoice.find(@invoice_items.invoice_id)

    if params[:status].present? 
      @invoice_items.update(status: params[:status])
      redirect_to merchant_invoice_path(@merchant.id, @invoice)
    end
  end
end