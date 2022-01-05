class MerchantInvoicesController < ApplicationsController
  def index
    @merchant = Merchant.find(params[:id])
    @invoices = Item.invoice_finder(params[:id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:invoice_id])
  end
end
