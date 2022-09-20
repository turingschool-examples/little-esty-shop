class InvoicesController < ApplicationController

    def index
        @invoices = Invoice.all
        @merchant = Merchant.find(params[:merchant_id])
    end

    def show
        @invoice = Invoice.find(params[:id])
        @merchant = Merchant.find(params[:merchant_id])
        @invoice_items = @invoice.invoice_items
    end

    def update
        @invoice = Invoice.find(params[:id])
        @merchant = Merchant.find(params[:merchant_id])
        @invoice_item = InvoiceItem.find(params[:id])
        @invoice_item.invoice.update(status: params[:status])
        redirect_to merchant_invoice_path(@merchant, @invoice)
    end
end

