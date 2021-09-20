# class InvoicesController < ApplicationController
#   def update
#     invoice = Invoice.find(params[:id])
#     invoice.update(invoice_params)
#     redirect_to merchant_invoice_path(invoice)
#   end
#
# private
#   def invoice_params
#     params.require(:invoice).permit(:status)
#   end
# end
