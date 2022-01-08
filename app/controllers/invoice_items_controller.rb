class InvoiceItemsController < ApplicationController
  def update
    @merchant = Merchant.find(set_merchant[:merchant_id])
    @invoice = Invoice.find(find_invoice_id)

    invoice_item = InvoiceItem.find(set_invoice_item[:id])
    invoice_item.update!(status: set_invoice_item[:invoice_item][:status])
    
    redirect_to [@merchant, @invoice]
  end

  private

  def set_invoice_item
    params.permit(:id, invoice_item: :status)
  end

  def set_merchant
    params.permit(:merchant_id)
  end

  def find_invoice_id
    InvoiceItem.find(params.permit(:id)[:id]).invoice_id
  end
end