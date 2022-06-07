class MerchantInvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update_attributes(status: params[:status])
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{params[:invoice_id]}"
  end
end
