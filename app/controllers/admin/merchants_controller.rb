class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all

    @enable = @merchants.where('status = ?', 'enable')
    @disable = @merchants.where('status = ?', 'disable')
    @top_five = Merchant.top_five_by_successful_transaction
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
  end
end
