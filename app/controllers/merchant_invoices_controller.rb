class MerchantInvoicesController < ApplicationController

  def index

    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show

    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:id])
  end

  def update
    @altered_invoice_item = InvoiceItem.find(params[:invoice_item_id])
    @altered_invoice_item.update(status: params[:status])
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{params[:invoice_id]}"
  end

end
