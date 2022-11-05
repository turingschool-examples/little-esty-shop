class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show 
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id]) 
    if params[:status]
      @merchant.update(status: params[:status])
    end

    redirect_to admin_merchants_path
  end

  def new 
    @merchant = Merchant.new
  end
end