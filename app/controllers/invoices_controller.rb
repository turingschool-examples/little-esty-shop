class InvoicesController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
    # @invoices = 
  end

end