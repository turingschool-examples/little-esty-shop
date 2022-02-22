class MerchantInvoicesController < ApplicationController
  def index
    @invoices = (Merchant.find(params[:id])).invoices
  end
end
