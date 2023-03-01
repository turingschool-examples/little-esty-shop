class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
		@invoices = @merchant.invoices.distinct
  end
end