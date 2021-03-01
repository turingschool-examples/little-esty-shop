class Merchant::InvoicesController < ApplicationController

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update(status: params[:status])
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{params[:id]}"
  end
end
