class InvoicesController < ApplicationController
    def index
        @invoices = Invoice.all
        @merchant = Merchant.find(params[:merchant_id])
    end
end