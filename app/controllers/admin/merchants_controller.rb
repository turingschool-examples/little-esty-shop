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
    @merchant = Merchant.find(params[:id])
    
    if params[:status]
      @merchant.update(name: params[:status])
      redirect_to "/admin/merchants"
    else
      @merchant.update(name: params[:name])
      @merchant.save
      flash[:alert] = "Information successfully updated"
      redirect_to "/admin/merchants/#{@merchant.id}"
    end
  end

end
