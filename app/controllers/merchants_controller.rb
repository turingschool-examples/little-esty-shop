class MerchantsController < ApplicationController

  def dashboard#maybeshow
    @merchant = Merchant.find(params[:merchant_id])

  end

end
