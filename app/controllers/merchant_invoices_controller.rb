class MerchantInvoicesController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @invoice = Invoice.find(params[:invoice_id])
    @merchant = Merchant.find(params[:merchant_id])
    @customer = Customer.find_by_invoice_id(params[:invoice_id])
  end

  def edit
    invoice = Invoice.find(params[:invoice_id])
    merchant = Merchant.find(params[:merchant_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    invoice = Invoice.find(params[:invoice_id])
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update!(invoice_item_params)

    redirect_to "/merchants/#{merchant.id}/invoices/#{invoice.id}"
  end

  private
    def invoice_item_params
      params.permit(:item_id, :invoice_id, :quantity, :unit_price, :status)
    end
end
