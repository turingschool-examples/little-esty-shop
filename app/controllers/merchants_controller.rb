class MerchantsController < ApplicationController 
    def index
        @merchant = Merchant.find(params[:id])
    end

end