class Admin::MerchantsController < ApplicationController 
    def index 
        @merchants = Merchant.all 
    end

    def show
        @merchant = Merchant.find(params[:id])
    end

    def edit 
        @merchant = Merchant.find(params[:id])
    end

    def update 
        merchant = Merchant.find(params[:id])
        merchant.update(merchant_params)
        if params[:status]
            redirect_to admin_merchants_path
        else 
            redirect_to admin_merchant_path(merchant), notice: "Merchant information was successfully updated!"
        end
    end

    def new 
        
    end

    private 
    def merchant_params 
        params.permit(:name, :status)
    end
end