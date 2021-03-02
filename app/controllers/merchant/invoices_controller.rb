class Merchant::InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @customer = Customer.find(@invoice.customer_id)
    @invoice_item = @invoice.invoice_items.first
    @item_name = Item.find(@invoice_item.item_id).name
  end

  def update
    invoice_item = InvoiceItem.find(params[:id])
    invoice_item.update(status: params[:invoice_item][:invoice_item_status])
  end
end
