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
        if merchant.update(name: params[:name])
            redirect_to "/admin/merchants/#{merchant.id}"
            flash[:alert] = "Your merchant has been updated."
        else 
            redirect_to "/admin/merchants/#{merchant.id}/edit"
            flash[:alert] = "error: #{error_message(merchant.errors)}"
        end 
    end 
end 