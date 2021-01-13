class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
  end

  def update
    @invoice = Invoice.find(params[:id])
    @invoice.update!(invoice_params)
    render :show
  end

  private

  def invoice_params
    params.require(:invoice).permit(:status)
  end
end
