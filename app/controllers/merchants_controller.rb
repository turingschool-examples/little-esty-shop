class MerchantsController < ApplicationController
  def show
    @merchant = Merchant.find(params[:id])
  end

  def admin_index
    @merchants = Merchant.all
  end
end
