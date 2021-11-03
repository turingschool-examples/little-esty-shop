class MerchantInvoicesController < ApplicationController

  def index
    @invoice = Invoice.find(params[:invoice_id])
  end
end