class MerchantsController < ApplicationController
  def login
    merchant_id = params[:merchant_id]
    redirect_to dashboard_merchant_path(merchant_id)
  end
end