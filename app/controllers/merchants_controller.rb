class MerchantsController < ApplicationController
  def show 
    @merchant = Merchant.find(params[:id])
    @invoices = @merchant.invoices.order(created_at: :asc)
  end
end