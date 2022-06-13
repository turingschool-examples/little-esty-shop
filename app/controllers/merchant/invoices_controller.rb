class Merchant::InvoicesController < ApplicationController
  def index
    @merchant_invoices = find_merchant.merchant_invoices
  end

  def show
    find_invoice
    find_merchant
  end

  def update
    invoice_item = InvoiceItem.find(params[:ii_id])
    invoice_item.update(status: params[:status])
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{invoice_item.invoice_id}"
    flash[:notice] = 'Item Status Has Been Updated!'
  end

  private

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_invoice
    @invoice = Invoice.find(params[:id])
  end
end
