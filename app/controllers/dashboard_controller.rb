class DashboardController < ApplicationController
  def index
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices
    @invoice_items = @merchant.invoice_items
  end

  def show
  end
end
