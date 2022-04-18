class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
  end

  def update
    invoice = Invoice.find(params[:invoice_id])
    invoice_item = invoice.get_invoice_item(params[:item_id])
    invoice_item.update(status: params[:select_status])
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{params[:invoice_id]}"
  end
end
