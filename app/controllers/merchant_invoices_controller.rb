class MerchantInvoicesController < ApplicationController
  def index
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
    @customer = Customer.find_by_invoice_id(params[:invoice_id])
  end
end
