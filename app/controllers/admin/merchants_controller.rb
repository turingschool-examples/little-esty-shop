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
      redirect_to admin_merchants_path
    elsif params[:name]
      @merchant.update(name: params[:name])
      flash.notice = "Sucessfully Updated"
      redirect_to "/admin/merchants/#{@merchant.id}"
    end
  end

  def edit 
    @merchant = Merchant.find(params[:id])    
  end

  def new 
    @merchant = Merchant.new
  end
end