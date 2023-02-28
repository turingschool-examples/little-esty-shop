class Merchants::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.merchant_invoices
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:id])
    @inv_items = @invoice.invoice_items
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice = merchant.invoices.find(params[:id])
    invoice_item = InvoiceItem.find_by(invoice_id: params[:id], item_id: params[:item_id])
    invoice_item.update(status: params[:status])
    # require 'pry'; binding.pry

    redirect_to merchant_invoice_path(merchant, invoice)
  end

  private
# don't seem to need these? 

  # def invoice_params
  #   params.require(:invoice).permit(:status, :customer_id)
  # end

  # def invoice_item_params
  #   params.require(:invoice_items).permit(:status)
  # end
end