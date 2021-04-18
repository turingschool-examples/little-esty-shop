class DashboardController < ApplicationController
  def index
    # Merchant.all
    @merchant = Merchant.find(params[:merchant_id])
    @invoices = @merchant.invoices.distinct_invoices
  end

  def show

  end
end
