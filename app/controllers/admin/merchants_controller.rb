class Admin::MerchantsController < ApplicationController
  def index
    @admin_merchants = Merchant.all
  end
end
