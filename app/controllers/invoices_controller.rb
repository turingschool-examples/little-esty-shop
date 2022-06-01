class InvoicesController < ApplicationController
  before_action :find_merchant

  def index
    @invoices = Invoice.invoices_with_merchant_items(@merchant)
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
