class MerchantInvoicesController < ApplicationController

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = @merchant.invoices.find(params[:invoice_id])
  end

end
