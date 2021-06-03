# app/controllers/merchant_controller.rb

class Admin::MerchantsController < ApplicationController

  def create
    Merchant.create(merchant_params)
    redirect_to '/admin/merchants'
  end

  def destroy
    merchant = Merchant.find(params[:id])
    merchant.destroy
    redirect_to '/merchants'
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def index
    @merchants = Merchant.all
    @top_five_merchants = Merchant.top_five
  end

  def new
  end

  def show
  @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    merchant.save
    flash[:notice] = "You have successfully updated this merchant!"
    redirect_to action: 'show', id: params[:id]
  end

  private

  def merchant_params
    params.permit(:name, :enabled)
  end
end