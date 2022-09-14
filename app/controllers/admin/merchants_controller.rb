class Admin::MerchantsController < ApplicationController
  def index
    @all_merchants = Merchant.all
  end
end