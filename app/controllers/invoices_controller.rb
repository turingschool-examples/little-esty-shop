class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.find(params[:merchant_id])
  end
end