class MerchantInvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
    @invoice_items = InvoiceItem.find_by(invoice_id: @invoice.id)
    @item = Item.find(@invoice_items.item_id)
  end
end