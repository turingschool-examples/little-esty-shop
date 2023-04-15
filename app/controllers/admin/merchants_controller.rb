class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def new
    
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end
end