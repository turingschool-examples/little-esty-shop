class MerchantInvoicesController < ApplicationController
    def index
        @merchant = Merchant.find(params[:merchant_id])
    end

    def show
        @invoice = Invoice.find(params[:id])
        @merchant = Merchant.find(params[:merchant_id])
    end

    def update
        invoice_item = InvoiceItem.find(params[:invoice_item_id])
        invoice_item.update(invoice_items_params)
        redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{params[:id]}"
    end

    private 
    def invoice_items_params
        params.permit(:status)
    end
end