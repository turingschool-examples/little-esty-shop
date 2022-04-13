class MerchantsController < ApplicationController
  def dashboard
    @merchant = Merchant.find(params[:id])
    @top_five = @merchant.top_five
  end

  def invoices

  end
end
