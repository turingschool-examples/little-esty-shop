# app/controllers/merchant_controller.rb

class MerchantsController < ApplicationController

  def create
    Merchant.create(merchant_params)
    redirect_to '/merchants'
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
  end

  def new
  end

  def show
  @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant)
    merchant.save

    redirect_to action: 'show', id: params[:id]
  end

  private

  def merchant_params
    params.permit(:name)
  end
end