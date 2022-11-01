class MerchantDashboardsController < ApplicationController
  def self.controller_path
    'merchants/dashboard'
  end

  def show
    @merchant = Merchant.find(params[:id])
  end
end