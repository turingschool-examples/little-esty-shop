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
        # redirect_to admin_merchants_path(@merchant.id)
        # # if @merchant.update(merchant_params)
        # #     flash.notice = "Merchant #{@merchant.name} was updated successfully!"
        # #     redirect_to "/admin/merchants/#{@merchant.id}"
        # else
        #     require 'pry'; binding.pry
        #     @merchant = Merchant.find(params[:id])
        #     render :edit
        # end
    end

    private
    def merchant_params
      params.require(:merchant).permit(:name, :status)
    end  
    
end