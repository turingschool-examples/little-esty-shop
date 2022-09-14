class AdminInvoicesController < ApplicationController
    def show
        @invoice = Invoice.find(params[:id])
    end
end