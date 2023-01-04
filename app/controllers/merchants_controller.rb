class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
    # require 'pry'; binding.pry
  end
end