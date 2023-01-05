module Admin
  class MerchantsController < ApplicationController
    def index
      @merchants = Merchant.all
    end

    def show
      @merchant = current_merchant
    end

    def edit 
      @merchant = current_merchant
    end

    def update 
      redirect_to "/admin/merchants/#{current_merchant.id}"
    end

    def current_merchant 
      Merchant.find(params[:id])
    end
  end
end