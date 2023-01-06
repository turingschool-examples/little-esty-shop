module Invoices
  class InvoiceItemsController < ApplicationController
    def update
      invoice = Invoice.find(params[:invoice_id])
      invoice_item = InvoiceItem.find(params[:id])
      merchant = invoice_item.item.merchant

      invoice_item.update!(invoice_item_params)
      redirect_to merchant_invoice_path(merchant, invoice)
    end

    private

    def invoice_item_params
      params[:invoice_item][:status] = params[:invoice_item][:status].downcase
      params.require(:invoice_item).permit(:status)
    end
  end
end