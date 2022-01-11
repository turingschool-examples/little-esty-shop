class AdminInvoiceItemsController < ApplicationController

  def update
    InvoiceItem.find(params[:invoice_item_id]).update(invoice_item_params)
    redirect_to "/admin/invoices/#{params[:invoice_id]}"
  end

  private
  def invoice_item_params
    params.permit(:status)
  end
end
