class Admin::MerchantsController < ApplicationController
  def index
    @enabled_merchants = Merchant.enabled_merchants
    @disabled_merchants = Merchant.disabled_merchants
    @top_merchants_by_revenue = Merchant.top_five_merchants_by_revenue
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
    @merchant = Merchant.new
  end

  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      flash[:notice] = "#{@merchant.name} has been Created"
      redirect_to admin_merchants_path
    else
      flash[:notice] = "Unable to Create - Missing Information"
      redirect_to new_admin_merchant_path
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    @merchant.update(merchant_params)
    if @merchant.save
      flash[:notice] = "#{@merchant.name} Information has been Updated"
      if params[:merchant][:status]
        redirect_to admin_merchants_path
      else
        redirect_to admin_merchant_path(@merchant)
      end
    else
      flash[:notice] = "Unable to Update - Missing Information"
      redirect_to edit_admin_merchant_path(@merchant)
    end

  end

  private
  def merchant_params
    params.require(:merchant).permit(:name, :status)
  end
end