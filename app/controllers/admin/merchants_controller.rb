class Admin::MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
  end
end
