class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    @merchant = Merchant.create!(    name: params[:name])
    redirect_to((admin_merchants_path))
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])

    if params[:status]
      @merchant.update!(      status: params[:status])
      redirect_to(admin_merchants_path)
    else
      @merchant.update!(      name: params[:name])
      redirect_to(admin_merchant_path(@merchant.id))
      flash[:notice] = "#{@merchant.name} has been successfully updated"
    end
  end
end
