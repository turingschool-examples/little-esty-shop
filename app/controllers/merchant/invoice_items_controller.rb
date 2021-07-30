class Merchant::InvoiceItemsController < ApplicationController


  def update
    require "pry"; binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @invoice_item = InvoiceItem.find(params[:ii_id])
    @invoice_item.update(status: params[:status] )
    @invoice_item.save

    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
    flash[:notice] = "Item status successfully updated!"
  end
end
