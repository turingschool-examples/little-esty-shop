class Admin::MerchantsController < ApplicationController
    layout 'admin'

    def index
        @merchants = Merchant.all
        @top_five = Merchant.top_five
    end

    def new
        @next_id = Merchant.last.id + 1
    end

    def create
        Merchant.create(new_merchant_params) 
        # merchant = Merchant.new(status: params[:status], name: params[:name])
        # merchant.save
        redirect_to admin_merchants_path
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
        # flash.notice = "Merchant #{@merchant.name} was updated successfully!"
        redirect_to "/admin/merchants/#{@merchant.id}", notice: "Merchant was updated successfully!"
        # redirect_to admin_merchants_path(@merchant.id)

        # if @merchant.update(merchant_params)
        #     flash.notice = "Merchant #{@merchant.name} was updated successfully!"
        #     redirect_to "/admin/merchants/#{@merchant.id}"
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

    def new_merchant_params
        params.permit(:name, :id)
    end
    
end