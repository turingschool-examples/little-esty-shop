class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.distinct
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @customer = @invoice.customer
    @invoice_items = @invoice.invoice_items
    @merchant_items = @merchant.items
    @items = @merchant_items.joins(:invoices, :transactions).where('result = ?', 1).select('merchant_items.*, sum(invoice_items.unit_price * invoice_items.quantity) as total_revenue').group(:id)
    binding.pry
  end
end
