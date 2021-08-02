class Admin::MerchantsController < ApplicationController
  def index
    
    @merchants = Merchant.all
    @top_merchants = Merchant.top_merchants
    
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    merchant = Merchant.new(name: params[:name], enabled: false)
    if merchant.save
      redirect_to admin_merchants_path
      flash[:alert] = "New Merchant Added"
    else
      redirect_to edit_admin_merchants_path
      flash[:alert] = "Unable to Create Merchant"
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if @merchant.update(merchant_params)
      redirect_to admin_merchant_path(@merchant.id)
      flash[:alert] = "Update Successful"
    else
      redirect_to edit_admin_merchant_path(@merchant.id)
      flash[:alert] = "Unable to Update Merchant"
    end
  end

  def enable
    @merchant = Merchant.find(params[:id])
    if params[:enabled] == "true"
      @merchant.update(enabled: true)
      redirect_to admin_merchants_path
    else
      @merchant.update(enabled: false)
      redirect_to admin_merchants_path
    end
  end

  private

  def merchant_params
    params.permit(:name, :enabled)
  end
end
