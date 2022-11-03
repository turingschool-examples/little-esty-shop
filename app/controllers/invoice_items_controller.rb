class InvoiceItemsController < ApplicationController


  def update
    @invoice_items = InvoiceItem.find(params[:id])
    @merchant = Merchant.find(params[:id])
    @invoice = Invoice.find(params[:id])
    
    # binding.pry

    if params[:pending].present? && @invoice_items.status == "packaged"|| @invoice_items.status == "shipped"
      @invoice_items.update(status: 0)
      redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    elsif params[:packaged].present? && @invoice_items.status == "pending" || @invoice_items.status == "shipped" 
      @invoice_items.update(status: 1)
      redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    elsif params[:shipped].present? && @invoice_items.status == "pending" || @invoice_items.status == "packaged"
      @invoice_items.update(status: 2)
      redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    end
  end
end