class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = Invoice.invoices_for(@merchant)
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @discounts = Discount.where(merchant_id: @merchant.id)
    @items = @merchant.items_by_invoice(@invoice)
  end
end