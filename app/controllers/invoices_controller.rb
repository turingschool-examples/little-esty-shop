class InvoicesController < ApplicationController
  before_action :invoices_merchant, only: [:index, :show]

  def index
    @invoice = Invoice.all
  end

  def invoices_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
