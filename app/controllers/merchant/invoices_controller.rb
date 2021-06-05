class Merchant::InvoicesController < ApplicationController
  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:invoice_id])
    @customer = Customer.where('id = ?', @invoice.customer_id).first
    @invoice_items = InvoiceItem.where('invoice_id = ?', @invoice.id)
    @total_revenue = @invoice_items.sum(:unit_price)

    if params[:status] != nil && params[:status] == 1
      InvoiceItem.where('merchant_id = ? AND invoice_id = ?', params[:merchant_id], params[:invoice_id]).first.update(status: 'Pending')
      redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    elsif params[:status] != nil && params[:status] == 2
      InvoiceItem.where('merchant_id = ? AND invoice_id = ?', params[:merchant_id], params[:invoice_id]).first.update(status: 'Packaged')
      redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    elsif params[:status] != nil && params[:status] == 3
      InvoiceItem.where('merchant_id = ? AND invoice_id = ?', params[:merchant_id], params[:invoice_id]).first.update(status: 'Shipped')
      redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    end
  end

  def index
    @merchant = Merchant.find(params[:id])
    @items = @merchant.items
    @invoices = Invoice.joins(:invoice_items).where("item.id = ?", @items)
  end
end
