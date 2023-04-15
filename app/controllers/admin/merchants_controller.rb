class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    require 'pry';binding.pry
    
    @merchant = Merchant.find(params[:id])
  end
end