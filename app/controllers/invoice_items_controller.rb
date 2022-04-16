class InvoiceItemsController < ApplicationController

  def update
    # require "pry"; binding.pry
    merchant = Merchant.find(params[:merchant_id])
    invoice = Invoice.find(params[:invoice_id])
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update({status: params[:status]})
    invoice_item.save
    redirect_to "/merchants/#{merchant.id}/invoices/#{invoice.id}"
  end


end
