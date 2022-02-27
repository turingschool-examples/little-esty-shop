class Admin::InvoicesController < ApplicationController
    def index
        @invoices = helpers.sortable(Invoice.all, params)
    end
    def show 
        @invoice = Invoice.find(params[:id])
    end
    def update 
        invoice_item = InvoiceItem.find(params[:item_id])
        invoice_item.change_status(params[:status]) if params[:status].present?
        redirect_to "/admin/invoices/#{params[:id]}/"
    end
end