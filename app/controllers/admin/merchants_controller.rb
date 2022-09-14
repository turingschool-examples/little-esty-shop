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
    @merchant.update(name: params[:name])
    @merchant.save
    redirect_to "/admin/merchants/#{@merchant.id}"
    flash[:success] = "You updated Merchant"
  end

end
