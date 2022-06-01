class InvoiceItemsController < ApplicationController

  def edit
  end

  def update
    invoice_item = InvoiceItem.find_by(invoice_id: params[:invoice_id])
    invoice_item.update(status: params[:ii_status])
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{params[:invoice_id]}"
  end
  
end