class AdminMerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    if merchant.update(merchant_params)
        redirect_to "/admin/merchants/#{merchant.id}"
        flash[:success] = "Merchant successfully updated!"
    else
        redirect_to "/admin/merchants/#{merchant.id}/edit"
        flash[:alert] = "Error: #{error_message(merchant.errors)}"
    end
  end

  def new
  end

  def create
    require "pry"; binding.pry
    merchant = Merchant.create
  end

  private
    def merchant_params
        params.permit(:name)
    end
end
