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
    merchant = set_merchant
    if params[:trigger]
      merchant.change_status
      redirect_to admin_merchants_path
    elsif merchant.name != params[:name]
      merchant.update!(name: params[:merchant][:name])
      redirect_to admin_merchant_path(merchant)
      flash[:notice] = "#{merchant.name} has been updated"
    else
      redirect_to admin_merchant_path(merchant)
    end
  end

  def new
    @merchant = Merchant.new
  end

  def create
    merchent = Merchant.create!(name: params[:merchant][:name], status: :disabled)
    redirect_to admin_merchants_path
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end
