class Merchant::BaseController < ApplicationController
  before_action :set_merchant

private
  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end