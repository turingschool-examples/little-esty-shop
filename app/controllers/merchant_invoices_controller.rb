class MerchantInvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:id])
  end

  def show
    @invoice = Invoice.find(params[:id])
    # require "pry"; binding.pry
  end

end
