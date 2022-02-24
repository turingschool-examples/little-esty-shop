class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:id])
    @invoice = Invoice.find(params[:invoice_id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @invoice = Invoice.find(params[:invoice_id])
    if params[:status] == "pending"
      @invoice.status = 0
    elsif params[:status] == "packaged"
      @invoice.status = 1
    elsif params[:status] == "shipped"
      @invoice.status = 2
    end
    redirect_to "/merchants/#{@merchant.id}/invoices/#{@invoice.id}"
  end

  private

  def invoice_status_param
    params.permit(:status)
  end
end
