class ApplicationController < ActionController::Base

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
