class AdminMerchantsController < ApplicationController
  def index
    @merchant = Merchant.all
  end
end
