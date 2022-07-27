class MerchantDashboardsController < ApplicationController
    def show
        @merchant = Merchant.find(params[:merchant_id])
    end
end