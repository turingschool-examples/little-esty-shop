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
    @merchants_enabled = Merchant.filter_by_enabled
    @merchants_disabled = Merchant.filter_by_disabled
    @top_five_merchants = Merchant.top_five
    # require 'pry'; binding.pry
  end

  def new
    @merchant = Merchant.new
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    if params.include? :index_redirect
      merchant.toggle(:enabled)
      merchant.save
      redirect_to action: 'index'
    else
      merchant.update(merchant_params)
      merchant.save
      flash[:notice] = "You have successfully updated this merchant!"
      redirect_to action: 'show', id: params[:id]
    end
  end

  private

  def merchant_params
    params.require(:merchant).permit(:name, :enabled)
  end
end