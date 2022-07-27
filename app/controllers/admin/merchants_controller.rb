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
        if params[:status] != nil 
            merchant.update(status: params[:status])
            redirect_to "/admin/merchants"
        elsif params[:name] != nil && merchant.update(name: params[:name])
            redirect_to "/admin/merchants/#{merchant.id}"
            flash[:alert] = "Your merchant has been updated."
        else 
            redirect_to "/admin/merchants/#{merchant.id}/edit"
            flash[:alert] = "Error: name can't be blank"
        end 
    end 
end 