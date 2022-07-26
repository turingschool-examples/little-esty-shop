class InvoicesController < ApplicationController
  
  def index
    @invoices = Merchant.find(params[:id]).invoices
  end

end