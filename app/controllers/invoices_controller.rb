class InvoicesController < ApplicationController
  def index
    @invoices = Invoice.all
    @merchant = Merchant.find(params[:merchant_id])
    @logo_photo = PhotoBuilder.logo_img
  end

  def show
    @invoice = Invoice.find(params[:id])
    @merchant = Merchant.find(params[:merchant_id])
    @logo_photo = PhotoBuilder.logo_img
  end
end