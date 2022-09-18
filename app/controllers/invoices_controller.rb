class InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id]) 
    @invoice = Invoice.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id]) 
    invoice = Invoice.find(params[:id])
    invoice_item = invoice.invoice_items.find_by(params[invoice_params])
    invoice_item.update(invoice_params)
    redirect_to merchant_invoice_path(merchant, invoice)
  end
  private
  def invoice_params
    params.require(:invoice).permit(:status, :item_id)
  end
end