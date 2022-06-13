class Merchant::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def display_discount
    percent_discount * 100
  end
end
