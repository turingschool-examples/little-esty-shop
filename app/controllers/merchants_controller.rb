class MerchantsController < ApplicationController
  # def index
  #   @merchants = Merchant.all
  # end
  #
  def dashboard#maybeshow
    @merchant = Merchant.find(params[:merchant_id])
  end
end
