class InvoicesController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :update]
  before_action :find_invoice, only: [:index, :show, :update]
  
  def index
    @invoices = Invoice.find_with_merchant(@merchant)
  end

  def show
  end

  def update
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update!(invoice_item_params)
    redirect_to "/merchants/#{params[:merchant_id]}/invoices/#{params[:invoice_id]}"
  end

  private
  def invoice_item_params
    params.permit(:status)
  end
end
