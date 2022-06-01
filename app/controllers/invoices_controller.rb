class InvoicesController < ApplicationController
  before_action :find_merchant

  def index
    @invoices = @merchant.invoices
  end

  def show
    @invoice = Invoice.find(params[:id])
  end
end
