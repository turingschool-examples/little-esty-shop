class InvoiceItemsController < ApplicationController
    def update
        @invoice_item = InvoiceItem.find(params[:id])
        @invoice_item.update(status: params[:invoice_item][:status])
        redirect_to merchant_invoice_path(params[:merchant_id], @invoice_item.invoice_id)
        flash[:success] = "Item Updated Successfully"
    end
end