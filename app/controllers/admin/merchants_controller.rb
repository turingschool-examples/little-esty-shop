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

  def new

  end

  def create
    merchant = Merchant.new(merchant_params)
    merchant.save
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    @merchant.save 
  end


    private
      def merchant_params
        params.permit(:id, :name, :status)
end
