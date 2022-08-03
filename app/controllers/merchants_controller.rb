class MerchantsController < ApplicationController
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
       if params[:status]
         redirect_to "/admin/merchants"
      elsif @merchant.update(merchant_params)
        redirect_to "/admin/merchants/#{@merchant.id}"
          flash[:alert] = "Successfully Updated"
      end
    end


  private
  def merchant_params
    params.permit(:id, :name, :status)
  end
end
