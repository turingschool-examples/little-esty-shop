class Admin::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :edit, :update]
  def index
    @merchants = Merchant.all
    @enabled_merchants = Merchant.enabled
    @disabled_merchants = Merchant.disabled
  end

  def show
  end
  
  def create
    @merchant = Merchant.new(m_params)
    @merchant.save
    flash.notice = 'Merchant Has Been Created!'
    redirect_to admin_merchants_path
  end

  def edit
  end

  def update
    @merchant.update(merchant_params)
    flash.notice = 'Merchant Has Been Updated!'
    redirect_to admin_merchant_path(@merchant)
  end
  
  private
  def set_merchant
    @merchant = Merchant.find(params[:id])
  end

  def merchant_params
    params.require(:merchant).permit(:name)
  end

  def m_params
    params.permit(:name)
  end
end