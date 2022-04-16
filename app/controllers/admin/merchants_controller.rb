class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
    @enabled = @merchants.status_enabled
    @disabled = @merchants.status_disabled
    @top_five = @merchants.top_5_by_revenue
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def new

  end

  def create
    merchant = Merchant.new(merchant_params)
    merchant.save
  end

  def update
    @merchant = Merchant.find(params[:id])
    previous_status = @merchant.status
    @merchant.update(merchant_params)
    @merchant.save
    flash[:notice] = "Update Successful!"

    if previous_status != @merchant.status
      redirect_to "/admin/merchants"
    else 
      redirect_to "/admin/merchants/#{@merchant.id}"
    end
  end


    private
      def merchant_params
        params.permit(:id, :name, :status)
    end
end
