class MerchantInvoicesController < ApplicationController 
    def show
        @invoice = Invoice.find(params[:invoice_id])
      
    end
    
end