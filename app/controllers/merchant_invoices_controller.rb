class MerchantInvoicesController < ApplicationController
  def index
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
  end
end
