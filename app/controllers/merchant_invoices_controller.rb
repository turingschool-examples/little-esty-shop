class MerchantInvoicesController < ApplicationController 
    def show
        @merchant = Merchant.find(params[:id])
        @invoice = Invoice.find(params[:invoice_id])
    end
    
end