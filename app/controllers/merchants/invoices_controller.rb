class Merchants::InvoicesController < ApplicationController
  def index
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @image_search = ImageSearch.new
    @logo = @image_search.images("Big Pharma")
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
  end
end