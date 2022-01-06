class AdminMerchantsController < ApplicationController
  def index
    @merchants = Merchants.all 
  end
end
