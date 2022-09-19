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
end

