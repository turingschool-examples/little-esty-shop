# module Admin

class Admin::MerchantsController < ApplicationController

  def index
    @merchants = Merchant.all
    #@merchant = Merchant.find(params[:id])
  end
end
