class InvoicesController < ApplicationController
  before_action :find_merchant, only: [:index, :show, :update]
  before_action :find_invoice, only: [:show, :update]

  def index
    @invoices = Invoice.invoices_with_merchant_items(@merchant)
  end

  def show
  end

  def update
    invoice_item = InvoiceItem.find(params[:invoice_item_id])
    invoice_item.update(invoice_item_params)
    redirect_to merchant_invoice_path(@merchant, @invoice)
  end

  private
  def invoice_item_params
    params.permit(:status)
  end
end
