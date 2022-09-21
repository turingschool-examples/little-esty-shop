class InvoicesController < ApplicationController

    def index
        @invoices = Invoice.all
        @merchant = Merchant.find(params[:id])
    end

    def show
        @invoice = Invoice.find(params[:id])
        @merchant = Merchant.find(params[:merchant_id])
        @invoice_item = @invoice.invoice_items.first
    end

    def update
      @invoice = Invoice.find(params[:id])
      @merchant = Merchant.find(params[:merchant_id])
      @invoice_item = @invoice.invoice_items.first
      @invoice_item.update!(invoice_item_params)
      redirect_to("/merchants/#{@merchant.id}/invoices/#{@invoice.id}")
    end

    private

    def invoice_item_params
      params.permit(:status)
    end
end
