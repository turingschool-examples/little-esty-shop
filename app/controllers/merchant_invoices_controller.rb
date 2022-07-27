class MerchantInvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
  end

  def update
    invoice_item = InvoiceItem.find_by(invoice_id: params[:invoice_id])
    invoice_item.update(status: params[:update_status])
  end
end
