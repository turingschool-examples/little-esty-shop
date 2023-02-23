class Admin::MerchantsController < ApplicationController 
  def show
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchants = Merchant.all
  end

  def new
 
  end

  def create 
   Merchant.create!(name: params[:name])
   redirect_to admin_merchants_path
  end
end