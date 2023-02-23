class Admin::MerchantController < ApplicationController
  def index
   @merchants = Merchant.all
  end
end