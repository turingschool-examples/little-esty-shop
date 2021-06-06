class Merchant::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
    @item_ids = Merchant.find(params[:id]).items.pluck(:id)
    @invoices = Invoice.joins(:invoice_items).where("item.id = ?", @item_ids)
  end

  def show
    @merchant = Merchant.find(params[:id])
    @invoice = @merchant.invoices.find(params[:id])
  end
end
