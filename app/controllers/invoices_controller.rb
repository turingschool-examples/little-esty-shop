class InvoicesController < ApplicationController
    def index
        @invoices = Invoice.all
        @merchant = Merchant.find(params[:id])
    end

    def show
        @invoice = Invoice.find(params[:id])

        if params[:merchant_id] != nil
            @merchant = Merchant.find(params[:merchant_id])
        end
    end
end