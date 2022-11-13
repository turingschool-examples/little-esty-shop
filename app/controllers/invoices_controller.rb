class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = Invoice.invoices_for(@merchant)
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @discounts = Discount.where(merchant_id: @merchant.id)

    invoice_items = InvoiceItem.where(invoice_id: @invoice.id)
    item_ids = invoice_items.pluck(:item_id)
    @items = @merchant.items.where(id: item_ids)
  end
end