class InvoicesController < ApplicationController
    def index
        @invoices = Invoice.all
        @merchant = Merchant.find(params[:id])
    end
end