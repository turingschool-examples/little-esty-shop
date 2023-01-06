module Admin
  class MerchantsController < ApplicationController
    def index
      @enabled_merchants = Merchant.find_by_status('enabled')
      @disabled_merchants = Merchant.find_by_status('disabled')
    end

    def show
      @merchant = Merchant.find(params[:id])
    end

    def edit 
      @merchant = Merchant.find(params[:id])
    end

    def update 
      current_merchant = Merchant.find(params[:id])

      if params[:status].present? && 
        current_merchant.update(merchant_params)

        # not sure the .save is required here 
        current_merchant.save 

        redirect_back fallback_location: "admin/merchants#{current_merchant.name}"
      else 
        current_merchant.update(merchant_params)

        # not sure the .save is required here
        current_merchant.save

        redirect_to "/admin/merchants/#{current_merchant.id}"
        flash[:alert] = "Merchant information successfully updated."
      end
    end

private 
    def merchant_params
      params.permit(:status, :name)
    end
  end
end