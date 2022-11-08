class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:id])
    @items = @invoice.items
  end

  def update
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice_item = InvoiceItem.find(params[:invoice_item_id])
    if params[:status]['pending']
      @invoice_item.update(invoice_items_params)
      redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    elsif params[:status]['packaged']
      @invoice_item.update(invoice_items_params)
      redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    elsif params[:status]['shipped']
      @invoice_item.update(invoice_items_params)
      redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    end
  end

  private

  def invoice_items_params
    params.permit(:status)
  end
end
