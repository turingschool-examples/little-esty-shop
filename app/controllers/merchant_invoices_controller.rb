class MerchantInvoicesController < ApplicationController 

  def index 
    require 'pry'; binding.pry
    @merchant = Merchant.find(params[:id])
  end
end
