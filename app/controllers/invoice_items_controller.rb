class InvoiceItemsController < ApplicationController

  def update
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update(invoice_item_params)
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{params[:invoice_id]}"
  end

  private
  def invoice_item_params
    params.permit(:status)
  end
end
