class Merchant::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
    @invoices = Invoice.joins(:invoice_items).where("item.id = ?", @items)
  end
end
