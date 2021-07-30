class Merchant::InvoicesController < ApplicationController

  def index
    @invoices = Merchant.merchant_invoices(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice_item = InvoiceItem.find(params[:ii_id])
    @invoice_item.update(status: params[:status] )
    @invoice_item.save

    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    flash[:notice] = "Item status successfully updated!"
  end

end
