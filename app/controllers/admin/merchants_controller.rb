class Admin::MerchantsController < ApplicationController
    layout 'admin'

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
        @merchant = Merchant.find(params[:id])
        @merchant.update(merchant_params)
        redirect_to "/admin/merchants/#{@merchant.id}"
    end

    private
    def merchant_params
      params.require(:merchant).permit(:name)
    end  
    
end