class ApplicationController < ActionController::Base

  def find_merchant
    @merchant = Merchant.find(params[:id])
  end
end
