class Merchants::InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
    @merchant = Merchant.find(params[:id])
  end

  def show
    # @item = Item.all
    @invoice = Invoice.find(params[:id])
    # require 'pry'; binding.pry
  end
end