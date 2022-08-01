class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    # @invoices = @merchant.invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
  end

  def update
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update({status: params[:status]})
    redirect_to merchant_invoice_path(params[:merchant_id], params[:id])
  end
end
