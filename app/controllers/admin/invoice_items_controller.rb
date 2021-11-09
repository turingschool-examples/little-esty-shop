class Admin::InvoiceItemsController < ApplicationController

  def update
    invoice_item = InvoiceItem.find(params[:id])

    invoice_item.update(status: params[:invoice_item][:status])

    redirect_to admin_invoice_path(invoice_item.invoice_id)
  end
end
