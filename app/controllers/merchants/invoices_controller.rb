class Merchants::InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.uniq
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice_items = @invoice.invoice_items
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice = Invoice.find(params[:id])
    invoice_item = InvoiceItem.find(params[:ii_id])
    invoice_item.update(:status => params[:status])
    
    redirect_to "/merchants/#{merchant.id}/invoices/#{invoice.id}"
    flash[:notice] = "Item status successfully updated!"
  end
end
