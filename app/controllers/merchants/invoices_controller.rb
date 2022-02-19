class Merchants::InvoicesController < ApplicationController
  def index
    @merchants = Merchant.find(params[:id])

  end

  def show
    @invoice = Invoice.find(params[:id])
  end

end
