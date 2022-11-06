class MerchantsController < ApplicationController
  def show
    @merchants = Merchant.all
  end
end
