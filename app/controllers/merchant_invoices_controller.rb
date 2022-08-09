class MerchantInvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:invoice_id])
    @bulkdiscounts = @merchant.bulkdiscounts
  end

  def update
    invoice = Invoice.find(params[:invoice_id])
    merchant = Merchant.find(params[:merchant_id])
    invoice_item = InvoiceItem.find_by(invoice_id: params[:invoice_id])
    invoice_item.update(status: params[:update_status])

    redirect_to "/merchants/#{merchant.id}/invoices/#{invoice.id}"
  end

end
