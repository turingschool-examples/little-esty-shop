class Admin::MerchantsController < ApplicationController
  def index
    @enabled = Merchant.enabled
    @disabled = Merchant.disabled
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
end