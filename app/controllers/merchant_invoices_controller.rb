class MerchantInvoicesController < ApplicationController


  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @merchants_items = @merchant.current_invoice_items(@invoice.id)
    # require "pry"; binding.pry
  end

end
