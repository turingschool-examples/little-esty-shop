class AdminMerchantsController < ApplicationController
    def index
        @merchants = Merchant.all
    end
end