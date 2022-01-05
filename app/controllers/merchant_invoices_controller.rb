class MerchantInvoicesController < ApplicationsController
  def index
    @merchant = Merchant.find(params[:id])
    @invoices = Item.invoice_finder(params[:id])
  end
end
