class Merchants::InvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:id])
    @merch_invoice = @merchant.invoices.distinct
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

end
