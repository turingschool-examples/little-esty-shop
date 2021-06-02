class Admin::MerchantsController < ApplicationController
  before_action :find_merchant, only: [:show, :edit, :update]

  def index
    @merchants = Merchant.all
  end

  private
  def find_merchant
    @merchant = Merchant.find(params[:id])
  end
end
