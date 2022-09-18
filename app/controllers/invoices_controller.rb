class InvoicesController < ApplicationController
    def index
        @invoices = Invoice.all
        @merchant = Merchant.find(params[:id])
    end

    def show
        @invoices = Invoice.find(params[:id])
        @merchant = Merchant.find(params[:id])
    end
end