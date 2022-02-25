class Merchants::InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:id])
    @merch_invoice = @merchant.invoices.distinct
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
    @items = @invoice.items
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    @inv_item = InvoiceItem.find(params[:invoice_item])
    @inv_item.update(status: params[:status])

    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{params[:invoice_id]}"
  end
private
  def invoice_params
    params.permit(:status)
  end
end
