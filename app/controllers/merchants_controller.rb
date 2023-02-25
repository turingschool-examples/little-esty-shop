class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    @invoices = @merchant.invoices
  end
end