class InvoicesController < ApplicationController

  def index
    @invoices = Merchant.find(params[:id]).invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
  end

end
