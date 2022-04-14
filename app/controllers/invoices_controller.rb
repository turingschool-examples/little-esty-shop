class InvoicesController < ApplicationController
  # before_action :find_merchant, only: [:index, :show]
  #
  # def index
  #   @invoices = @merchant.invoices.distinct
  # end
  #
  # def show
  #   require 'pry'; binding.pry
  #   @invoice = Invoice.find(params[:id])
  #   @customer = @invoice.customer
  #   @invoice_item = InvoiceItem.where(invoice_id: params[:id].first)
  # end
  def index
    # require 'pry'; binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.unique_invoices
  end

  def show
    require 'pry'; binding.pry
    @merchant = Merchant.find(params[:merchant_id])
    @invoice = Invoice.find(params[:id])
    @merchants_items = @merchant.current_invoice_items(@invoice.id)
  end
end
