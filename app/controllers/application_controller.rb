class ApplicationController < ActionController::Base

  def find_merchant
    # require 'pry'; binding.pry
    @merchant = Merchant.find(params[:merchant_id])
  end
end
