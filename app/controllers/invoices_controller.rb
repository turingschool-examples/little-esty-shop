class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @total_revenue = @invoice.total_revenue(@merchant.id)
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    # require "pry"; binding.pry
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update!(status: params[:status])
    # require "pry"; binding.pry
    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end
end
