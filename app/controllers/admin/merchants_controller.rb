class Admin::MerchantsController < ApplicationController
  def index
    # require 'pry'; binding.pry
    @merchants = Merchant.all
  end 

  def show 
    @merchant = Merchant.find(params[:id])
  end
end

