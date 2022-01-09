class InvoicesController < ApplicationController
  before_action :do_merchant, only: [:index, :show]

  def index
    @invoices = @merchant.invoices.distinct
  end

  def show
    @invoice = Invoice.find(params[:id])
    @customer = @invoice.customer
    @invoice_item = InvoiceItem.where(invoice_id: params[:id]).first
  end
end
